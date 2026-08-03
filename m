Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE93C55184
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 07:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F74610E537;
	Mon,  3 Aug 2026 07:33:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=solid-run.com header.i=@solid-run.com header.b="RU1oUmHm";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="RU1oUmHm";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11020102.outbound.protection.outlook.com [52.101.69.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F0AC10E282
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 07:23:22 +0000 (UTC)
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=LzHOw8js4aJTOUgyxKfHRuESke1rfQVxYsjeCjzyQbhukceWZ0GwrT9VAzdRNA0V61sCAltbkqCh2D2KFXiXiSI3g+cD/nnU4rtwpwDNpd1hZGywg181UTWnzrCGo4mUFqXXf13cc2SUIeszoyozYv0CvDU1F8WMwQA35Gr5xyzJ1BhpHwI6HqeTjIWLrJz6/6GDecr43Eig0c0w+E7oX7IBj9+cyBAInAO9AzkdY07UPdN3Q5UmUGgmd2rKaGUZV8w2zekkwB9GyANWntu3ROSXHSL0fyv2kcrvPON/ZfoVu2ig0Ho7buL3+bPz2jg3OpFRMiIcqr/5mQ4q28dHoA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5WMt7uTUOvZQ87QFAylHt8VwczCnGGYg3F1YzJUvb8=;
 b=VDdO0IWT+Ppig84Ega7QuR7CyG0auDtY7DsGTQ1pBCzMAR1hhVctjNcEUPdZLFraG/5wRhIyHXL2U/Uiw9FZid07m8LDmq1QIDGiDtboVUgXVTWi5d8d7HSchfyLXZi1QzCdsHKOvskRXtCnWkwR4Y0IomCUMJ5RtsG77EShRo8W3rqCFK535MFWDNJP4fMNROLddb3hU1tPm566cMVki1ZOtSUKpbQlYQG5z5n3Tm3vAZmq18fV0EUxsRcvwIgdw52cPsSqcxg/u0vdsSOtfqllJvpTl7d5UqqOqwmhOWEY3NOqIa/0X+Gr9uKzQwuP6zjjRtoXTGMReTtnPVCXzQ==
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
 bh=I5WMt7uTUOvZQ87QFAylHt8VwczCnGGYg3F1YzJUvb8=;
 b=RU1oUmHm/o2ZFayT4uA33fe5eqr/lExgktgjidUb6gFy0hHDNS52vibMN/aSbqdeW9Y2m6Z3gi2lx0Vjb58ObPZp4FXKgErmEAf4bvkGKwfCdQ6Ue/6NpHdUZPcYh27gLcg/4lRyEZ7aLXYbnY+z4DVfNEmir+sx/BfoOYL0U+KH7H/X+Ekygzih60tkJh2S3e5TAGJIdfDATSsJwKD+Q9rKcYvoPc2bIhCGwznwI0YimIfpZu7nd4rBFpJt51JXLDrag2ptYVW0ANLTwonPmvRTwHA1SohGKNOzzT1dg2nx6MLtHe3V+vqkHcsugehg0+Z94Gr/2ayOKWEFiz1u/Q==
Received: from PA7P264CA0361.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:37c::23)
 by AS8PR04MB9012.eurprd04.prod.outlook.com (2603:10a6:20b:42e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 07:23:17 +0000
Received: from AM4PEPF00025F96.EURPRD83.prod.outlook.com
 (2603:10a6:102:37c:cafe::ab) by PA7P264CA0361.outlook.office365.com
 (2603:10a6:102:37c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.17 via Frontend Transport; Mon, 3
 Aug 2026 07:23:16 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AM4PEPF00025F96.mail.protection.outlook.com (10.167.16.5) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.1 via
 Frontend Transport; Mon, 3 Aug 2026 07:23:16 +0000
Received: from emails-4261273-12-mt-prod-cp-eu-2.checkpointcloudsec.com
 (ip-10-20-5-232.eu-west-1.compute.internal [10.20.5.232])
 by mta-outgoing-dlp-141-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with
 ESMTPS id E4802806DD; Mon,  3 Aug 2026 07:23:15 +0000 (UTC)
X-Mailbox-Line: From b'jon@solid-run.com' Mon Aug  3 07:23:05 2026
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1785741795;
 b=EOQd+wkI/0kminEpDYI4lgtjF9vVDHb2N+N7QslFwFNPax3mydu6ySKnexRtjGVChocg0
 SvuEKjtDpxzf5yM3kLmzngiTR9jMqc0N88pnjZdT688It3TcDDBA6lpOeLREu/Kpt6VdJlc
 3peDUGMCQ3DUKDcANJBpf4VUJIqWtBg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1785741795; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=I5WMt7uTUOvZQ87QFAylHt8VwczCnGGYg3F1YzJUvb8=;
 b=mvACaixJ0+NPOYwa/U6H7OVPGABuPLdN8Dg4jfDfsOpo5SoOIrYiSr6sf+ObwHCAz2sLi
 wCPnspkld1BgVdlfS8kFbBfNC3ZplEfUNA/VRR1odTTzv/lyUiGqyVWvzkvUA1IIKAsjgmT
 JjIlrJQoIrI4WXtFjTMexzRK9BXPGRY=
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5WMt7uTUOvZQ87QFAylHt8VwczCnGGYg3F1YzJUvb8=;
 b=RU1oUmHm/o2ZFayT4uA33fe5eqr/lExgktgjidUb6gFy0hHDNS52vibMN/aSbqdeW9Y2m6Z3gi2lx0Vjb58ObPZp4FXKgErmEAf4bvkGKwfCdQ6Ue/6NpHdUZPcYh27gLcg/4lRyEZ7aLXYbnY+z4DVfNEmir+sx/BfoOYL0U+KH7H/X+Ekygzih60tkJh2S3e5TAGJIdfDATSsJwKD+Q9rKcYvoPc2bIhCGwznwI0YimIfpZu7nd4rBFpJt51JXLDrag2ptYVW0ANLTwonPmvRTwHA1SohGKNOzzT1dg2nx6MLtHe3V+vqkHcsugehg0+Z94Gr/2ayOKWEFiz1u/Q==
Received: from DB8PR04MB7082.eurprd04.prod.outlook.com (2603:10a6:10:129::21)
 by GV1PR04MB11514.eurprd04.prod.outlook.com (2603:10a6:150:284::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 07:23:01 +0000
Received: from DB8PR04MB7082.eurprd04.prod.outlook.com
 ([fe80::af44:86c5:f59b:4d39]) by DB8PR04MB7082.eurprd04.prod.outlook.com
 ([fe80::af44:86c5:f59b:4d39%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 07:23:01 +0000
From: Jon Nettleton <jon@solid-run.com>
To: Liz Fong-Jones <lizf@honeycomb.io>, "bjorn@helgaas.com" <bjorn@helgaas.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, =?utf-8?B?SWxwbyBKw6RydmluZW4=?=
 <ilpo.jarvinen@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Jon
 Nettleton <jon.nettleton@gmail.com>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: Fix BAR resize for devices on a root bus
Thread-Topic: [PATCH v2] PCI: Fix BAR resize for devices on a root bus
Thread-Index: AQHdEkhp/vWPxDCUu0GxdsyhCAICALaH+9SugABbWgCAA7U/MA==
Date: Mon, 3 Aug 2026 07:23:01 +0000
Message-ID: <DB8PR04MB7082527C1E1BCDA91C7CAB4AE7D52@DB8PR04MB7082.eurprd04.prod.outlook.com>
References: <20260712-pci-rebar-root-bus-v2-1-a1b9107a82dc@honeycomb.io>
 <20260731162424.GA1571989@bhelgaas>
 <CAC0H+B-p5MT4M03MMkbxr_dLjsuThkxPv3--Ciant0i2MvvqDw@mail.gmail.com>
 <CABhMZUX+8tjN1Hz=tf6bm+K7BV4r=1RxctiN6W_UPz9+yxG+Qg@mail.gmail.com>
In-Reply-To: <CABhMZUX+8tjN1Hz=tf6bm+K7BV4r=1RxctiN6W_UPz9+yxG+Qg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-traffictypediagnostic: DB8PR04MB7082:EE_|GV1PR04MB11514:EE_|AM4PEPF00025F96:EE_|AS8PR04MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: a49aab5c-2650-49b2-8f82-08def13015f5
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|6133799003|56012099006|8096899003|4143699003|10067099003|22082099003|18002099003|13003099007|38070700021;
X-Microsoft-Antispam-Message-Info-Original: n3T10T+0oGNb2+Hyi72JUKakMhIAWDPFv/nroCC0nDx7/4YEgK93mFhzWx73gK7fqnwCk3JijKKD0Q7MrnHvdIxhlAyHm8jBQN2zB5N3PSsZ+Ab7MF691LAcOGzTPNC/VnIjVVfmhDuAQtz37OfemO+pTXbw1iBat+Uv5LfGYLqE/GTF5gIxef867ciKYDEH7xegjZRuJRc5fmulBEdKLxrANmZs3KpOgUY7eYvdj/ip6w8OYKOi8D5Vj0csfJLRKwkFoivpNvVqJZKw2ueh3ZuVXOg09Q1wHAia2j6xbghbfjvA7JCVfZ20i+UFDR5mE0OL45vh2Yk8YqaojzLAPgj+bd8Bn3p9z7JYj+u3xvJmKgT4ADTaYOxUn20hYKijMrnVN490rX8UrN8aatkze2mY5Ak+tpEzfHGmlPveRWqf60/tcPYuMva2/4IXi1YX4Pf+feAvPQuidybvWk5dL6VKXttQdWEIPzUdx6Lcr31suOiPV1/uv8BC1tXNaVAYbmqt8lmmfsSgBBkw4/Y7uAvjqMZv+4HlKzJv0Ag9Yl9rbbovq3+/YkQsESAxPJ0ciWQh73B2Qo6D1FDdVvpXv+1MUac3+zj4OVpoP6eNR9UrZqIQest8ffkCn/nuRpowwP+UxWxJ8JSwVJOwgU0GmH7iYVZUg5iba2pbpDAMLPWLTpBHQRefNDXcIV0gIBdJ1tAD1MBGwZCMH5mOdb3aSn9YWRT2AswEYg0xkuVRpq0=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB8PR04MB7082.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(6133799003)(56012099006)(8096899003)(4143699003)(10067099003)(22082099003)(18002099003)(13003099007)(38070700021);
 DIR:OUT; SFP:1102; 
Content-Type: multipart/alternative;
 boundary="_000_DB8PR04MB7082527C1E1BCDA91C7CAB4AE7D52DB8PR04MB7082eurp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OLua7W6jfTLSMLxFbXw03VimiOH31qnGjxqV08eas3teurbPR3QfB6wjpePpM2kPKvNY5quizu8tOTD+7Gyy7C5/EUiR0fEaHB2+quzf9mQNyrSwMVraJ8TjDzAX0P+WzFWVo5AEPyA57Fy3/oWQQEQp4NmbQtKz9iIYu55o190Vh4uuQa4w7lEP4s+6SXVJwwAb63NsUqmn5cPv6TNnIcaUc3AKQRzB9cL2w1TGEAiBa5G40HPbFmWFG1BWHQzmQO0BwaT4xl7zexH5j1pFlyJbyDa41LKh0R6E2/tzENwMASuFC6+xf5ar0N6UOJvULz2NMC7ynVmH4bk7Gt1fAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11514
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 4e4cb0dff5944f27a83d2d0d6f4700bc:solidrun,
 office365_emails, sent, inline:5ad20416d43753ea3029d1c841282255
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nx6VgsvhTvSVizknMg6oSs0P7Oi2POeEbwAI1QoOWVchacewNL30ogqFVqWyVicKvNWw//lEcFDOQCxxUWCsgsHZ5YLLA+3FB3rOHM6sePtCjRGuiRlU6OBnW/yavOrNLPW137Jimu4droCrYUfy0HC8ifXFupCSyQ8jPPU9IvdGSahOyvC0FyTICNcB259oeEcbGzizOPn4BrS90kTzLe1im4+4uQ4MQrjE/kOclMO3E15+yJZt5sM06EZUmKAcqqi5cvBlDZyyEkzM49XHUTpXbRtlXJ0OB/u/UeJWt0GcC4tsc2Re+Wnf78b03CTTWBng7Fwxw8OJCtAxvL/sKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5WMt7uTUOvZQ87QFAylHt8VwczCnGGYg3F1YzJUvb8=;
 b=ayE1xOsknVb4q9KsRK/XcrNgfqSCVf/Ewd4OwDpVb5pX6Djp493MEVWjtZB7V9veCuzWdWFiMMrgCBo0jq0RmFXLDt0iuwH2UxVM9nwQU/8VAXkuguWycdTVW6jruEPkK+fLMA74QeCy0TsAE2ipA3XTkcT4AeIoodk9SxaQnESy0bLWz32QFghGZgEMqgxn/F0aHy6NPfBXZjjvl8qXhNA94iOALmfeW0nU6w7ftvxxcAoCmdNOEXQGT+F4JxbYFGsFGSVIhiv2oX1emrg2M7+2x5lUEJXRLdYh987VbzSuv7WNpV6iO96fnrE30Foem1JzoopuS5024XXCSkHqhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ff571446-61ae-47a1-f6d2-08def1300ce3
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|36860700016|23010399003|35042699022|14060799003|376014|8096899003|22082099003|18002099003|4143699003|56012099006|13003099007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: AnRXnANJuWaCRADtcs2880Ge4j3rFHOrTMoyKL5TZgDwCVxmg/xLmO4jOlfanJ7tkaX27g804TiRE7bW38moL8DhIx/zNcQicfYDj+mK1ki+ZPe7j7g5J56KSxPHmkIXZQ0/IQFyjLeurtj8TNxcO97p4Ed6sKRA8rxv3wWndSZCRGHwQX3trZlWRB7MVgNIT0Eph6GHEnRrm/MKmp11/bnqpDzN5BK0OFjTCLPqXUqsYnBu4FEi4ovqqfS0Mwxv7/M5q5x8CugPrHY7SZPcryetrsBcpgGx2u/F1p3L7MGAKO8G/gq6IefxnMCEQUQ854T7eYHoOlYqeu1BDYXCIWCGOlT12A6anyD6rG94ZkWvSkdtRQhxXyUA2WWwLa8k+bpUdY+eAgAgvajLgn0BBSAT5VJTb/3FFBDV2QgtZoTKQ01+GybJPoDkYdSFacej3YI1HPJ8msGJSto82aDTzQ+4h0r70AmZRrYHxytmv5ZzSsinPzbL7APqnU/FvwMqA3pRsfdfUMl7Bt9cqh5tc8q1LN4TDKjgIJVzL6iCIJCDMIpOLgPGYf68IOgjLRIFjFcJ9F9zmWqoQFL5fdCy+e8/g3JGG5+JQjsMtkD5nlm5QhSiaZydv/+bn1p8/AO+jtff+46HMkocQKnq1MErAX+8kryIEiPowiq02IrOKxrLZs7ltr5gKmmoIPOvJl4w4Z6UIr0nyAzHJeCQGUWodw==
X-Forefront-Antispam-Report: CIP:52.17.62.50; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:eu-dlp.cloud-sec-av.com; PTR:eu-dlp.cloud-sec-av.com;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700016)(23010399003)(35042699022)(14060799003)(376014)(8096899003)(22082099003)(18002099003)(4143699003)(56012099006)(13003099007)(6133799003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ikolhTxCxDE6YEeejEkTQzoI6c93uZ2WeI2xZqnyBlg9nW3X3EJMf2EeipLZC67o2OMeI7pD7xZtg5yjUKxaATd1ZNgso3+j3KkvMGYTwDuL6TdnlUNYlDxSdA0TkW5H/5L/9UtfyT7r1LsQNjqkMMXhH/LyZByMSOZBaPpJkGudrEzf6KOvkmn7uOBIFNMCfdE5VEdA0jzFugp94DxhMauadqs1YYBL2LamapPW61yhGBksL91d0PRqF6Z4KAy1mlXXhckxqbE6tF38zH19F0p6XlGY8+J5cHQxtIsDl5bJpAs8WPC8X1B8nN7BXlaoexsC+NBOqL++Wl75q5YgPa6AtFYIK/L28W8zLLiEGKNbJF4Axf+XVY8IHhrPeVpukHq/gmCtNw86KOXCn2MH8B3lrt5ehhsW8BwCdPPfryTHrQc0TocpJBFLFjdnMorj
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 07:23:16.1477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a49aab5c-2650-49b2-8f82-08def13015f5
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82; Ip=[52.17.62.50];
 Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9012
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

--_000_DB8PR04MB7082527C1E1BCDA91C7CAB4AE7D52DB8PR04MB7082eurp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

VGhlIG1haW4gcXVpcmsgd2l0aCB0aGUgaGFyZHdhcmUgdG9wb2xvZ3kgaXMgdGhhdCB0aGUgcm9v
dCBwb3J0J3MgYWRkcmVzcyBzcGFjZSBpcyBvdXRzaWRlIG9mIHRoZSBFQ0FNIGFkZHJlc3Mgc3Bh
Y2UgdXNlZCBmb3IgdGhlIGRldmljZXMgYmVsb3cgaXQuIEZvciBBcm0gU3lzdGVtUmVhZHkgY29t
cGxpYW5jZSwgYW5kIHRvIGFsbG93IGRpc3Ryb3MgdG8gYm9vdCBvdXQgb2YgdGhlIGJveCB0aGUg
b25seSBvcHRpb24gd2FzIHRvIG9ubHkgZXhwb3NlIHRoZSBkZXZpY2VzIG9uIHRoZSBidXMgYW5k
IGNvbmZpZ3VyZSB0aGUgcm9vdCBwb3J0IGluIHRoZSBmaXJtd2FyZS4gVGhpcyB3YXMgbm90IG91
ciBmaXJzdCBjaG9pY2UgYnV0IGF0IHRoZSB0aW1lIHF1aXJrcyBmb3IgdGhlIFBDSWUgQUNQSSBz
ZXR1cCB3ZXJlIG5vIGxvbmdlciBiZWluZyBhY2NlcHRlZCBpbiBtYWlubGluZS4NCg0KSSB3b3Vs
ZCBiZSBoYXBweSB0byByZXN1cnJlY3QgdGhlIEFDUEkgcXVpcmsgcGF0Y2ggbmVlZGVkIHNvIHRo
ZSBidXMgd291bGQgbG9vayBtb3JlIG5vcm1hbCBpZiB0aGF0IHdvdWxkIGJlIGFjY2VwdGVkIG5v
dy4NCg0KLUpvbg0KDQoNCk9uIEZyaSwgSnVsIDMxLCAyMDI2IGF0IDEyOjE14oCvUE0gTGl6IEZv
bmctSm9uZXMgPGxpemZAaG9uZXljb21iLmlvPiB3cm90ZToNCj4+IE1heWJlIHRoaXMgaXMgYSB0
YW5nZW50LCBidXQgSSdtIGN1cmlvdXMgYWJvdXQgdGhpcyB0b3BvbG9neS4gIElzIHRoaXMNCj4+
IHJ1bm5pbmcgYXMgYSB2aXJ0dWFsaXplZCBndWVzdD8gIEF0IHRoZSBoYXJkd2FyZSBsZXZlbCwg
YSBQQ0llDQo+PiBlbmRwb2ludCBtdXN0IGhhdmUgYSBSb290IFBvcnQgc29tZXdoZXJlLCBldmVu
IGlmIGl0IGlzbid0IHZpc2libGUgdG8NCj4+IHRoZSBPUyAoYXMgaXMgb2Z0ZW4gdGhlIGNhc2Ug
aW4gdmlydHVhbGl6ZWQgZ3Vlc3RzKS4NCj4NCj4gRGVmZXIgdG8gSm9uIG9uIHdoYXQgdGhlIGFj
dHVhbCBoYXJkd2FyZSBjb25maWd1cmF0aW9uIGlzLCBidXQgdGhpcyBpcw0KPiBwaHlzaWNhbCBo
YXJkd2FyZSwgbm8gdmlydHVhbGlzYXRpb24sIHJ1bm5pbmcgYXMgdGhlIFVFRkkgcmF0aGVyIHRo
YW4gVS1Cb290DQo+IChkZXZpY2V0cmVlKSB2YXJpYW50LiBTZWU6DQo+IGh0dHBzOi8vZGV2LnNv
bGlkLXJ1bi5jb20vbnhwL2x4MjE2MGEvY29tLXNvbS9seDIxNjBhLWNvbS1oYXJkd2FyZS11c2Vy
LW1hbnVhbCNibG9jay1kaWFncmFtDQoNCkkgZ3Vlc3MgdGhpcyBtdXN0IGJlIHRoZSBkcml2ZXJz
L3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbGF5ZXJzY2FwZS1nZW40LmMNCmRyaXZlci4g
IFRoZSBjb21taXQgbG9nIG1lbnRpb25lZCB0aGlzOg0KDQo+Pj4gICBhbWRncHUgMDAwNDowMTow
MC4wOiBCQVIgMCBbbWVtIDB4YTQwMDAwMDAwMC0weGE0MGZmZmZmZmYgNjRiaXQgcHJlZl06IHJl
bGVhc2luZw0KDQpzbyB0aGUgR1BVIGlzIG9uIGJ1cyAwMSwgd2hpY2ggaXNuJ3QgYSBuaWNlIHJv
dW5kIGJ1cyBudW1iZXIgbGlrZSByb290IGJ1c2VzDQp1c3VhbGx5IGFyZS4gIFRoZSB0eXBpY2Fs
IHRoaW5nIHdvdWxkIGJlIGEgcm9vdCBwb3J0IG9uIGJ1cyAwMCB3aXRoIGEgc2Vjb25kYXJ5DQpi
dXMgMDEsIGFuZCBhbWRncHUgYmVpbmcgb24gdGhhdCBidXMgMDEuICBDYW4geW91IHNoYXJlIGEg
ZG1lc2cgbG9nPyAgSXQNCnNob3VsZCBpbmNsdWRlIHRoZSBseDIxNjBhIGhvc3QgYnJpZGdlIGRl
dGFpbHMgYW5kIHRoZSBQQ0llIHRvcG9sb2d5IGJlbG93IGl0Lg0K

--_000_DB8PR04MB7082527C1E1BCDA91C7CAB4AE7D52DB8PR04MB7082eurp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgc3R5bGU9
ImRpc3BsYXk6bm9uZTsiPiBQIHttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO30gPC9zdHls
ZT4NCjwvaGVhZD4NCjxib2R5IGRpcj0ibHRyIj4NCjxkaXYgY2xhc3M9ImVsZW1lbnRUb1Byb29m
IiBzdHlsZT0iZm9udC1mYW1pbHk6IEFwdG9zLCBBcHRvc19FbWJlZGRlZEZvbnQsIEFwdG9zX01T
Rm9udFNlcnZpY2UsIENhbGlicmksIEhlbHZldGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAx
MnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+DQpUaGUgbWFpbiBxdWlyayB3aXRoIHRoZSBoYXJk
d2FyZSB0b3BvbG9neSBpcyB0aGF0IHRoZSByb290IHBvcnQncyBhZGRyZXNzIHNwYWNlIGlzIG91
dHNpZGUgb2YgdGhlIEVDQU0gYWRkcmVzcyBzcGFjZSB1c2VkIGZvciB0aGUgZGV2aWNlcyBiZWxv
dyBpdC4gRm9yIEFybSBTeXN0ZW1SZWFkeSBjb21wbGlhbmNlLCBhbmQgdG8gYWxsb3cgZGlzdHJv
cyB0byBib290IG91dCBvZiB0aGUgYm94IHRoZSBvbmx5IG9wdGlvbiB3YXMgdG8gb25seSBleHBv
c2UNCiB0aGUgZGV2aWNlcyBvbiB0aGUgYnVzIGFuZCBjb25maWd1cmUgdGhlIHJvb3QgcG9ydCBp
biB0aGUgZmlybXdhcmUuIFRoaXMgd2FzIG5vdCBvdXIgZmlyc3QgY2hvaWNlIGJ1dCBhdCB0aGUg
dGltZSBxdWlya3MgZm9yIHRoZSBQQ0llIEFDUEkgc2V0dXAgd2VyZSBubyBsb25nZXIgYmVpbmcg
YWNjZXB0ZWQgaW4gbWFpbmxpbmUuJm5ic3A7PC9kaXY+DQo8ZGl2IGNsYXNzPSJlbGVtZW50VG9Q
cm9vZiIgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcHRvcywgQXB0b3NfRW1iZWRkZWRGb250LCBBcHRv
c19NU0ZvbnRTZXJ2aWNlLCBDYWxpYnJpLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6
ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPg0KPGJyPg0KPC9kaXY+DQo8ZGl2IGNsYXNz
PSJlbGVtZW50VG9Qcm9vZiIgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcHRvcywgQXB0b3NfRW1iZWRk
ZWRGb250LCBBcHRvc19NU0ZvbnRTZXJ2aWNlLCBDYWxpYnJpLCBIZWx2ZXRpY2EsIHNhbnMtc2Vy
aWY7IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPg0KSSB3b3VsZCBiZSBo
YXBweSB0byByZXN1cnJlY3QgdGhlIEFDUEkgcXVpcmsgcGF0Y2ggbmVlZGVkIHNvIHRoZSBidXMg
d291bGQgbG9vayBtb3JlIG5vcm1hbCBpZiB0aGF0IHdvdWxkIGJlIGFjY2VwdGVkIG5vdy48L2Rp
dj4NCjxkaXYgY2xhc3M9ImVsZW1lbnRUb1Byb29mIiBzdHlsZT0iZm9udC1mYW1pbHk6IEFwdG9z
LCBBcHRvc19FbWJlZGRlZEZvbnQsIEFwdG9zX01TRm9udFNlcnZpY2UsIENhbGlicmksIEhlbHZl
dGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+
DQo8YnI+DQo8L2Rpdj4NCjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcHRvcywgQXB0b3NfRW1i
ZWRkZWRGb250LCBBcHRvc19NU0ZvbnRTZXJ2aWNlLCBDYWxpYnJpLCBIZWx2ZXRpY2EsIHNhbnMt
c2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPg0KLUpvbjwvZGl2
Pg0KPGRpdiBjbGFzcz0iZWxlbWVudFRvUHJvb2YiIHN0eWxlPSJmb250LWZhbWlseTogQXB0b3Ms
IEFwdG9zX0VtYmVkZGVkRm9udCwgQXB0b3NfTVNGb250U2VydmljZSwgQ2FsaWJyaSwgSGVsdmV0
aWNhLCBzYW5zLXNlcmlmOyBjb2xvcjogcmdiKDAsIDAsIDApOyI+DQo8c3BhbiBzdHlsZT0iZm9u
dC1zaXplOiAxMXB0OyI+PGJyPg0KPGJyPg0KT24gRnJpLCBKdWwgMzEsIDIwMjYgYXQgMTI6MTXi
gK9QTSBMaXogRm9uZy1Kb25lcyAmbHQ7bGl6ZkBob25leWNvbWIuaW8mZ3Q7IHdyb3RlOjxicj4N
CiZndDsmZ3Q7IE1heWJlIHRoaXMgaXMgYSB0YW5nZW50LCBidXQgSSdtIGN1cmlvdXMgYWJvdXQg
dGhpcyB0b3BvbG9neS4mbmJzcDsgSXMgdGhpczxicj4NCiZndDsmZ3Q7IHJ1bm5pbmcgYXMgYSB2
aXJ0dWFsaXplZCBndWVzdD8mbmJzcDsgQXQgdGhlIGhhcmR3YXJlIGxldmVsLCBhIFBDSWU8YnI+
DQomZ3Q7Jmd0OyBlbmRwb2ludCBtdXN0IGhhdmUgYSBSb290IFBvcnQgc29tZXdoZXJlLCBldmVu
IGlmIGl0IGlzbid0IHZpc2libGUgdG88YnI+DQomZ3Q7Jmd0OyB0aGUgT1MgKGFzIGlzIG9mdGVu
IHRoZSBjYXNlIGluIHZpcnR1YWxpemVkIGd1ZXN0cykuPGJyPg0KJmd0Ozxicj4NCiZndDsgRGVm
ZXIgdG8gSm9uIG9uIHdoYXQgdGhlIGFjdHVhbCBoYXJkd2FyZSBjb25maWd1cmF0aW9uIGlzLCBi
dXQgdGhpcyBpczxicj4NCiZndDsgcGh5c2ljYWwgaGFyZHdhcmUsIG5vIHZpcnR1YWxpc2F0aW9u
LCBydW5uaW5nIGFzIHRoZSBVRUZJIHJhdGhlciB0aGFuIFUtQm9vdDxicj4NCiZndDsgKGRldmlj
ZXRyZWUpIHZhcmlhbnQuIFNlZTo8YnI+DQomZ3Q7IDxhIGhyZWY9Imh0dHBzOi8vZGV2LnNvbGlk
LXJ1bi5jb20vbnhwL2x4MjE2MGEvY29tLXNvbS9seDIxNjBhLWNvbS1oYXJkd2FyZS11c2VyLW1h
bnVhbCNibG9jay1kaWFncmFtIiBpZD0iT1dBMjNjMDY4MDgtYmFlMy0zYzI2LTc3OTItYTFhZTA4
NzQ1ZmY1IiBjbGFzcz0iT1dBQXV0b0xpbmsiIGRhdGEtYXV0aD0iTm90QXBwbGljYWJsZSI+DQpo
dHRwczovL2Rldi5zb2xpZC1ydW4uY29tL254cC9seDIxNjBhL2NvbS1zb20vbHgyMTYwYS1jb20t
aGFyZHdhcmUtdXNlci1tYW51YWwjYmxvY2stZGlhZ3JhbTwvYT48YnI+DQo8YnI+DQpJIGd1ZXNz
IHRoaXMgbXVzdCBiZSB0aGUgZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLWxh
eWVyc2NhcGUtZ2VuNC5jPGJyPg0KZHJpdmVyLiZuYnNwOyBUaGUgY29tbWl0IGxvZyBtZW50aW9u
ZWQgdGhpczo8YnI+DQo8YnI+DQomZ3Q7Jmd0OyZndDsmbmJzcDsmbmJzcDsgYW1kZ3B1IDAwMDQ6
MDE6MDAuMDogQkFSIDAgW21lbSAweGE0MDAwMDAwMDAtMHhhNDBmZmZmZmZmIDY0Yml0IHByZWZd
OiByZWxlYXNpbmc8YnI+DQo8YnI+DQpzbyB0aGUgR1BVIGlzIG9uIGJ1cyAwMSwgd2hpY2ggaXNu
J3QgYSBuaWNlIHJvdW5kIGJ1cyBudW1iZXIgbGlrZSByb290IGJ1c2VzPGJyPg0KdXN1YWxseSBh
cmUuJm5ic3A7IFRoZSB0eXBpY2FsIHRoaW5nIHdvdWxkIGJlIGEgcm9vdCBwb3J0IG9uIGJ1cyAw
MCB3aXRoIGEgc2Vjb25kYXJ5PGJyPg0KYnVzIDAxLCBhbmQgYW1kZ3B1IGJlaW5nIG9uIHRoYXQg
YnVzIDAxLiZuYnNwOyBDYW4geW91IHNoYXJlIGEgZG1lc2cgbG9nPyZuYnNwOyBJdDxicj4NCnNo
b3VsZCBpbmNsdWRlIHRoZSBseDIxNjBhIGhvc3QgYnJpZGdlIGRldGFpbHMgYW5kIHRoZSBQQ0ll
IHRvcG9sb2d5IGJlbG93IGl0Ljwvc3Bhbj48L2Rpdj4NCjwvYm9keT4NCjwvaHRtbD4NCg==

--_000_DB8PR04MB7082527C1E1BCDA91C7CAB4AE7D52DB8PR04MB7082eurp_--
