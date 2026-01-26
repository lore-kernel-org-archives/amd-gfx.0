Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A4AD13C24
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 14:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDDC410E0E1;
	Mon, 26 Jan 2026 14:46:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JSFrycCl";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6221A10E0E1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 14:46:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=laF9Xvaez/S7o0Jd7AZFShP8yRqPdaROjo2yZPL2IW3QRVeZTUxFDYuqejXlnupfn3eeAyQAndY3Dix2jJbo42912PwWfN+HkHwPWJkIUxsfpxd6Ga1BkvRgFMro8VrTTrE0dkgGpHXmVl4ynYPfTYolrrH/8mKb8zM7tmMs9cc4qUwk9Z0BQTXIR7bxCUqhTsDxoLoDYuGLcMQwqE+bfBMgIm1MPY962MEgNZ+Ugh5n4yBOh/PATUsbRufSbnnrYXgAeWlnYjI3JzVhfrXHTMDHAUL8zHwuGLR5pKddj17Wxyba9FPEmqaSeeTul0vIsHc8QlpsQZzjx8wWPfmYNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XQvrucTlrI5b8A22sNiZrhhCokQyG3CHR+eETvEXAQ=;
 b=AoQ/l+NtcBHTJ1y2FMYKjFCGzaR5tgxnhjGXn8km/T8XxB7BK5G9pyPlsZ8sseAjlJz5Icfojr82imuZqDymKR+hm7U8s8ugnw6S0jwa//qjlCKgjYVQgeEx2vA8Ke+E0SzCb9l+/w5Y7H3NVAF7BjPoW2a5VZ+wR9lagfrNoZABm905Neh30q1ndK1B87l6J0AJCTrWzZjDXVCcTFwxnbp6/GFNJBYSQ4/CA2jjqKCQMLq5/O3rJ8Ucdl77dTnIJ7nbcMxYkhDlNuAqDuKD5lEbDnCdOIFTR3j7tXRa1eieldIJs6EMiRLdH4JBjvs4kxqTBD0ZsS0e1C3EA6xHQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XQvrucTlrI5b8A22sNiZrhhCokQyG3CHR+eETvEXAQ=;
 b=JSFrycCltAlO5ZRoPRFx46fDB+Sw9+BLZ0Ac7NAa85lmy+WWJYh5SyI6gVkBXc3U0ZTHOhSzoPX3KxVwiLN/BSvXs7vhuXoQGjdPKqYc6K4eWHf44vLxnFIREwiR7gAj9XNW+Vda4mcs0OqSUfR69U5UFNsq0erP1M2z+DEL3AM=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 14:46:31 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 14:46:31 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Send RMA CPER at bad page loading
Thread-Topic: [PATCH] drm/amdgpu: Send RMA CPER at bad page loading
Thread-Index: AQHci7NSeef9uDGClkKMq/doBL/CiLVfR4IAgACz+0CAA8dUgIAAyWNA
Date: Mon, 26 Jan 2026 14:46:31 +0000
Message-ID: <BL1PR12MB589811A52B70DDDC7A9EBDA18593A@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260122152501.351937-1-kent.russell@amd.com>
 <PH7PR12MB87965382F541A9E18CB67EF9B094A@PH7PR12MB8796.namprd12.prod.outlook.com>
 <BL1PR12MB589834F3ACE3526E2AA118F28594A@BL1PR12MB5898.namprd12.prod.outlook.com>
 <PH7PR12MB87960E8669B7A76762E9C920B093A@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB87960E8669B7A76762E9C920B093A@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-23T16:58:23.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|CH2PR12MB4118:EE_
x-ms-office365-filtering-correlation-id: 4d590090-f19a-4558-3f3b-08de5ce9b1b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?q7maFPX1OPNGmnwbDS4RecQw+KRJnCOEsG57HzzQsxrwmUzole1c0MFc3ons?=
 =?us-ascii?Q?nwaG7lfEhit+EBLQCPFyMCE2tjuVRkOfXt1qJiSaweDZS4JCwbfcpUejpXtP?=
 =?us-ascii?Q?A7jF4MUGoZXzfG9NgsXHVSaed7EAyGHjKkMAfw28ld/ZZtoT8cOhx0aiN4SG?=
 =?us-ascii?Q?je4p9+x2ZApKJvn8fm47RsHEIcFI19jbZd5itAZlASf1p5hrtjWmcZ42b8Db?=
 =?us-ascii?Q?HBgpLqZEaMTqdt5YGuHanYtV+0oe8PbPxaBAkX9rxzQz57xsS5gadw+u4tqh?=
 =?us-ascii?Q?XY+Sv/MJGsSSB/n710MQzhfYQWCE5Y5/IDBiViVOKAAiTUTSv6QOG7a0+yOA?=
 =?us-ascii?Q?sD+tD3j9gz5XV8LNylbO+ltngkqS8dShdZu1XoN13o30X+/Kyi0gOSMXp0lm?=
 =?us-ascii?Q?rGfSNjFex7L0+vc0wi6SyPHqdNcUnXQLfzOGZQZEtNCxdA6lmsLj2mVr2uHt?=
 =?us-ascii?Q?G7LXMkv+vcNBwHVtrZEioAqvCNtz1YYIE0dCdpVjyoMsKbkUtcEjztIO1CeO?=
 =?us-ascii?Q?3tFztKW6b40mSTSsVIzDiQ6hDeNvXt6EWvyAj2Ids1VSIU+G2i0eOP5Wuq50?=
 =?us-ascii?Q?lxSbEAb0PyXi0qZi4AtAMYOWXx6nlM3wbR67eNne4N2lELrBnzKMqTQ2dfAo?=
 =?us-ascii?Q?XcA11LmcJEV/Daz6OmU9nGt1g2dbH/flHwioE7nt0ylGgaiLg/7Epd3jro0E?=
 =?us-ascii?Q?xVlZ5wfUr5szAHDD1m0M89D7CvylC1+ft4u9vJC7aH5Jw+oMRlHbKTyjdZb+?=
 =?us-ascii?Q?CjmtalyFS9C49bpi22y9bPnVDV0uzyiTocFF3rMnzw/8R4AHV5S0jYTz9MDj?=
 =?us-ascii?Q?6CD/4UyDMq9F0n0hk+y0Vl0o4ejwZdMvNkiwNuPFwJ7NdpL1dO2ekzb1rHPl?=
 =?us-ascii?Q?3gGgighwISb3C/nqsw7FjawgPeSJTh3MfyYKs7fW/Oe4C1yXI4ONDv4k0zIg?=
 =?us-ascii?Q?qVY53NEoOAfLqQQu0L5zlCrl3AaZrlSgEPwMTrmo///g16L+q/wLdGxHf7W7?=
 =?us-ascii?Q?Caz5VCgkYUGW7F+NxZhsr2Fwem/f+uB1D0UAxNg5vyXTJHQTmdGMB3+nAWbq?=
 =?us-ascii?Q?toHBQGCXeEyPhkF6AqU7O9lEjmJNwcm0WYMG0rXJUQsapsUGcn0o6QamUPIy?=
 =?us-ascii?Q?AnCUfXjiMWpO2os/bvROH02WyRLl3CMzGqARci/TjD4v2YSnyuyYllzqfRCE?=
 =?us-ascii?Q?/Z6lTQGa5cjatIKFXUEXK/e9+8XO6VGzVHJZJ60ziANha0itSb/OUNInNkzk?=
 =?us-ascii?Q?tK4BfklC8BmncGihVnb4CbQQp1KDT0pREhNgBnRnKNpP1J/KHnOeJoew88V7?=
 =?us-ascii?Q?qZHhb0Lh/oVWAxZ4/ID/sLiGMrfqFK/NXKsmdthcsJGIUePoHHBV6mxw7zA8?=
 =?us-ascii?Q?JqIZt5FWl4sUudzJu2WR+G/zg95AmYKHfGo0laPwhCJsPjgL8fUEegtnZxyQ?=
 =?us-ascii?Q?TLFWqABGMRsbz0E+SnFgyqc3wxXBGfDyEUcA6iby8AzMQDj7tREWfBudZ3Td?=
 =?us-ascii?Q?LxOs9L83vuma2whmYJKcwrpN1cy8SZ8sG2k8JT5KhpCfq9OOaFlL1WS5WVFy?=
 =?us-ascii?Q?qvXurzOk1/2l8muUMmXtiVaQw3AkmXpWAIrm+TH/fafJ3JShUDyFdQ+q20If?=
 =?us-ascii?Q?9We+L3vA9ktfYALRk8+MSr0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/XJowz2QA/h5OWgM+kSmatW5Wd0pgQOSBFHmj72MbIhkfdyfsjzjfSTo99c8?=
 =?us-ascii?Q?6QZdl7aNurT3G8Zm01633KpylJl3ikZA4GtBagPwLOtXFRNfI3m3IDTZHWi3?=
 =?us-ascii?Q?m24tANOFnhOVUBC6K1Gp1aDqzG0k5V4mCyi5EJeRMMGTMShmJrWH6u0ScvsA?=
 =?us-ascii?Q?C7b43e99NZEJQByvJoEHDxNZN8QmWOpgvYeqovDOWeZE3cdJBTcLGMTRTmeM?=
 =?us-ascii?Q?9SkT49RSbskTlmUC5zygAyVlmId5ndZ9qrdb9OZKwNIAEOQ1lqZHlDkk/PKT?=
 =?us-ascii?Q?q01fVlfaLZfeXMgTa+xaCwxzpxmmCqtdtEJUwOkI3a8myJzIaZdx/Dm/awM7?=
 =?us-ascii?Q?5e55TrJe2TfE9Rxwq02tiLV6+JDmQhMCOVrtG1WrKN/xi+7Vf1sqoPGel0od?=
 =?us-ascii?Q?dWUd/DMJBlNjPAJPfcOJf+7Ft828pqEcdrcXF+cTeR/jUXsxFd8vA5WSKImq?=
 =?us-ascii?Q?zXUFnm5nk3ikNo11sxl34Zib7ja3QpwjqaCpTHZy7RtRdzC6ClW5mSelDjpn?=
 =?us-ascii?Q?WKTrWicUvCxwwYjN7U//NyDTl8VTw9O1Do8jCRpS+XV3/TZLtVR4H5zARRHd?=
 =?us-ascii?Q?Pb5NQsmFkDXPOwDL6aYyZnh96+JBXI3YWyLr4VJ0SYe3oqBpPQSsRgNtzyoF?=
 =?us-ascii?Q?BMJxdAr0ef6BOFVYfnl/vbP32/n/K9uUeis0lJRFD3hjympx3KVheZdFCYRa?=
 =?us-ascii?Q?i2dab6C4CjOmcqUucNIpPZCb8BZ7325xYuFjMM/W/G0iIffC2BX4DgB0th92?=
 =?us-ascii?Q?1nEZxWDl0nUPX4Syu9WNwAQg9bbSLck0ZdjQzv+UC4knwyhmwkzDD7bRMfLb?=
 =?us-ascii?Q?aTP8z6OaxyaO+xCmwH41TcxykLPwCh6ndSL93skxHgNRTjLQ3BYlZB003khN?=
 =?us-ascii?Q?o/x1GwR90qdg/bJSgxMQixjUTZZHqMc6eCqonF9fHL6NbI+IKlnMj/twzQKm?=
 =?us-ascii?Q?jKN/EBQ3vjKi2KTBSQ9kv82wN4MnIShPZEibcvZ2LZurEO3FpMkhzyFamYKs?=
 =?us-ascii?Q?7xQcvA/hnPM07uk9MaKylyq4A6GRnkowlA1irvp9RbWtwFgp/Jxc07MoaEXG?=
 =?us-ascii?Q?PFqp+Pofmkye+jO7L5lrANXdQOKSBNY16WinYIabzUDZk/J1vcvMUOl6wwXm?=
 =?us-ascii?Q?dvBP4TzhZQNU8/G3ABjV1u/nqFH9ixT+O0HnEwdSPotc5pB6Ck3y/c7ADeD2?=
 =?us-ascii?Q?9mPk9A830yUKPXr6VUTJL0MKbZ7EdHPiyugHKHLRdWSySRtkbjDiPyxVzDxN?=
 =?us-ascii?Q?6fca04pNeuKr9sknnicjU5v1o3IfEiX3Sd2dI21Ex15NgadDipd+9WBVheNY?=
 =?us-ascii?Q?Xy0Q8TjZzpTTwmroiQClyMSjxTgckT6ONeViRoLwCosk8AmuTiN239UaZhf6?=
 =?us-ascii?Q?LetwbTLqxTQ+3nO+qT3hFliB6/RU/Uz+Jq1M/4dM+LnGZMSJEu5dne9ezRGF?=
 =?us-ascii?Q?dMx0Yo3B1YnBn8+22W12a7j6dCbxV8B1oXm2RvMkbhOM5p3aCBRGgQdijaJU?=
 =?us-ascii?Q?4f1jpDteemn69RTIy3IEg7Ig98K8Ln9ojCrbDVOaHrv57YSfdFKaMNTbl4MM?=
 =?us-ascii?Q?xeK5/ZdO2xCCXQfyedIl1EYrtMqIirsjlcWtKUiyPvMpmRX1hbuxis2blqXB?=
 =?us-ascii?Q?IXg7QFp1uuk+UwSipSytVJ+FH7JB5/QBkksSsuy8anexWtxGq4N7kdNpJVlt?=
 =?us-ascii?Q?/vqf7uAyw3fg//nzJjHnG8F9T1uRhJnnzKcGSilwO6sbBcgl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d590090-f19a-4558-3f3b-08de5ce9b1b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 14:46:31.1874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rEM3tBVUfHlJz3hJt6gajLbWoR77yUhcFSJB2d6y5hIyrBXjRRnNfyQsaqPyRtdjyNhm43PGIoW7iOQtvvpiPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118
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

> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Sunday, January 25, 2026 9:40 PM
> To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: Send RMA CPER at bad page loading
>
> [Public]
>
> > -----Original Message-----
> > From: Russell, Kent <Kent.Russell@amd.com>
> > Sent: Saturday, January 24, 2026 1:02 AM
> > To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> > Subject: RE: [PATCH] drm/amdgpu: Send RMA CPER at bad page loading
> >
> > [Public]
> >
> > Thanks Tao. This was really just to get some feedback on how to do this=
. And if
> there
> > were any dependencies. Ideally we want to send out a CPER for the situa=
tion in
> the
> > commit message. I can definitely add that as a comment.
> >
> > For the 2nd part, I am not sure. The big issue is that systems that rel=
y on CPERs to
> > know when a GPU is bad will not have a CPER for this type of situation =
until they
> > take a new UE. So we want to alert them every time we load more than th=
e
> > threshold. Would in-band also benefit from that? Is there a drawback to=
 having
> both?
> > I figure more alerts is always better when it comes to unhealthy HW.
> >
> >  Kent
> >
>
> [Tao] Hi Kent, can system bootup successfully in this case? If the answer=
 is no, I
> think in-band CPER is unnecessary, otherwise user may be confused about t=
he
> inconsistence of in-band and out-of-band cper.

What we were seeing was that after the patches from you and Gangliang, the =
system could initialize amdgpu with a massive number of retirements (previo=
usly it couldn't even init). But it took roughly 10 minutes from modprobe t=
o completion on the node I was testing on. For health checks, a 10min init =
would get the node flagged for service, then it would need to be triaged by=
 the service team to figure out why it took so long. The CPER would help he=
re since that way the node would immediately be flagged as RMA, instead of =
needing to be triaged as to the reason for the slow init.

Again, I am not a CPER/RAS expert. The hope here is that we can just signal=
 to OOB that we need to RMA the node, instead of waiting for the next UE to=
 trigger that. If in-band would benefit from that too, then great. Because =
right now, all we see is a slow initialization and then we need to dig into=
 dmesg to figure out why.

Hopefully that helps explain the unique situation a bit more clearly.

 Kent

>
> > > -----Original Message-----
> > > From: Zhou1, Tao <Tao.Zhou1@amd.com>
> > > Sent: Friday, January 23, 2026 1:14 AM
> > > To: Russell, Kent <Kent.Russell@amd.com>;
> > > amd-gfx@lists.freedesktop.org
> > > Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Russell, Kent
> > > <Kent.Russell@amd.com>
> > > Subject: RE: [PATCH] drm/amdgpu: Send RMA CPER at bad page loading
> > >
> > > [AMD Official Use Only - AMD Internal Distribution Only]
> > >
> > > > -----Original Message-----
> > > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > > > Kent
> > > Russell
> > > > Sent: Thursday, January 22, 2026 11:25 PM
> > > > To: amd-gfx@lists.freedesktop.org
> > > > Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Russell, Kent
> > > > <Kent.Russell@amd.com>
> > > > Subject: [PATCH] drm/amdgpu: Send RMA CPER at bad page loading
> > > >
> > > > Some older builds weren't sending RMA CPERs when the bad page
> > > > threshold was exceeded. Newer builds have resolved this, but there
> > > > could be systems out there with bad page numbers higher than the
> > > > threshold, that haven't sent out an RMA CPER. To be thorough and
> > > > safe, send an RMA CPER when we load the table, if
> > > the
> > > > threshold is met or exceeded, instead of waiting for the next UE to
> > > > trigger the
> > > CPER.
> > > >
> > > > Signed-off-by: Kent Russell <kent.russell@amd.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > > > index 64dd7a81bff5..469d04a39d7d 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > > > @@ -1712,6 +1712,10 @@ int amdgpu_ras_eeprom_check(struct
> > > > amdgpu_ras_eeprom_control *control)
> > > >                       dev_warn(adev->dev, "RAS records:%u exceeds
> > > > 90%% of threshold:%d",
> > > >                                       control->ras_num_bad_pages,
> > > >                                       ras->bad_page_cnt_threshold);
> > > > +             if (amdgpu_bad_page_threshold !=3D 0 &&
> > > > +                     control->ras_num_bad_pages >=3D ras-
> > > > >bad_page_cnt_threshold)
> > > > +                     amdgpu_dpm_send_rma_reason(adev);
> > > > +
> > >
> > > [Tao]: 1. Better to add comment to describe this special case;
> > >
> > > 2. Do we need to trigger in-band cper as well? Like:
> > >
> > > if (adev->cper.enabled && !amdgpu_uniras_enabled(adev) &&
> > >     amdgpu_cper_generate_bp_threshold_record(adev))
> > >         dev_warn(adev->dev, "fail to generate bad page threshold cper
> > > records\n");
> > >
> > > >       } else if (hdr->header =3D=3D RAS_TABLE_HDR_BAD &&
> > > >                  amdgpu_bad_page_threshold !=3D 0) {
> > > >               if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
> > > > --
> > > > 2.43.0
> > >
> >
>

