Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460A6CA6004
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 13:22:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B541A10F5C1;
	Wed,  7 Oct 2026 13:22:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.b="M5Wvz/fI";
	dkim-atps=neutral
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com
 [185.183.30.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B63810E277
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 08:13:30 +0000 (UTC)
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
 by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6967beUZ2137312; Tue, 6 Oct 2026 08:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=p1; bh=YjEglQ1LnhKnCxcSHGvBWjNf41O59Og
 /gnS5gxQFRW4=; b=M5Wvz/fIu03TgbOK2UjIUuY39OC5UgCc0NL74eFmmV/YsYG
 WkPZnIbZc/WNh15xdTtY3QHf9L9hLS8Ec/TkQwDaLLQF4RSDSLCjZERf6tObQosP
 CkxFAOTJWgwhXdCGRl90BhyZM2dTU5TDKUwcM9g382Zg8b46qNlo0dWAKlNM3WNx
 5/kEtVsi2qCJ3B/yra+gWp+cIWkQY7qJgd4DBfHA8F7Q6Q85ACwJ/TjdwrB9vAfm
 N4dOpK6nfBWJaG1d+CMuwSbO/hVG7/uzviSVjbnN0f6L2poSh0noFd8nDQfHdn6c
 FewVrvEvtVU3wwpIFGASIVlsJSD0pxNrraE3GpA==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012062.outbound.protection.outlook.com [52.101.43.62])
 by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4h2qkhbc1v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Tue, 06 Oct 2026 08:13:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwMojKvSMvZS183nnGS4odNj+HHfRnFxGwZNRZJsgqlonQg0B+SXkgpYsV6Y3jeUWd/S0ysY9IQsQVUlI9/lZvpASZ7StT7hTOwAUrOkUxTitSSkd2zwmYkvaMhQM7jL9odAj5xjr0cZ3opggJOdzGsYxr6KNicDthvtNiVtqrImJJxml/TS0faVkuu2nlRPlrevHpnpbPsSK6l03v+KBJQyl+TGDTuDDh2X93UJG35jVH7zsGFyFGNQF3I5WJ+vdfzVEGhs4DMFYK/Cz7O2P6R2p+nOv70VWttcM7dm/W9vKdx0/8DZuO0dTxGSncOq9G/ZHkOFhhX1iwbRrfQpzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjEglQ1LnhKnCxcSHGvBWjNf41O59Og/gnS5gxQFRW4=;
 b=RK8JymmqXPFDO8mfUAbDuZCogp2EQK3aQ8+ce8keoR/33f35Y4vaDXxe1mm8fTvIt6YnTZgqJ5oBP2i/lqLGg8yWnSwEj+GAQjoPiGOAuQ+x7pHM/fCYlaHrP+Cc8/CzYwYXuq494Br8mCeWdmV1O5npTdrKO/tEocaYLqqCiOTpkMu6yUqTHRGLjxM66uhq5yUzAg1Di7k4wJy6AM3LWW88Xi7/LScpTsY9tV84GWC4m423lW+gT+Mu5adLfvHWWU/HdehGu4W9ZQuf2VLJx5UDyEzDUCSDE/PY7R6rO8yw4A4M5xYuZUdJM5SnsDl4eD5Ama84fi+deFZYFDjEZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BY3PR13MB4865.namprd13.prod.outlook.com (2603:10b6:a03:36c::24)
 by BY5PR13MB3652.namprd13.prod.outlook.com (2603:10b6:a03:226::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 08:13:18 +0000
Received: from BY3PR13MB4865.namprd13.prod.outlook.com
 ([fe80::9df8:d4ad:f70a:2f27]) by BY3PR13MB4865.namprd13.prod.outlook.com
 ([fe80::9df8:d4ad:f70a:2f27%4]) with mapi id 15.21.0472.015; Tue, 6 Oct 2026
 08:13:18 +0000
From: "Grochowski, Maciej" <Maciej.Grochowski@sony.com>
To: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Nikolas Joshua Britton <nbritton@exabit.io>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Mesih.Kilinc@sony.com" <Mesih.Kilinc@sony.com>
Subject: Re: PCI: bridge window undersized when child bridge windows are
 larger than their alignment (regression since 3958bf16e2fe, v7.0)
Thread-Topic: PCI: bridge window undersized when child bridge windows are
 larger than their alignment (regression since 3958bf16e2fe, v7.0)
Thread-Index: AQHdO24WCqkreQXgc0CitK/+yn2UO7a8vL8AgBvWn1CAEbyNAIAGCkfH
Date: Tue, 6 Oct 2026 08:13:18 +0000
Message-ID: <BY3PR13MB48650E00DA1B7C484E6BE66781952@BY3PR13MB4865.namprd13.prod.outlook.com>
References: <20260903063124.9316-1-nbritton@exabit.io>
 <9b63ab96-338a-82aa-3bf7-e56b545a3b47@linux.intel.com>
 <BY3PR13MB4865407C39BBCF92A742BDF781842@BY3PR13MB4865.namprd13.prod.outlook.com>
 <cda8e95d-4175-965e-4abe-bb456c52486b@linux.intel.com>
In-Reply-To: <cda8e95d-4175-965e-4abe-bb456c52486b@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sony.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR13MB4865:EE_|BY5PR13MB3652:EE_
x-ms-office365-filtering-correlation-id: 78b62a19-ad32-40eb-03bf-08df2381ada3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|38070700021|11063799006|4143699003|8096899003|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: 7ZDoB99otEkkZxxp9YSp0WApcss3sMJVPIkC4iCSuJlzwsIYXclSrsG/0sxyHVFWaVsDYqS12HbsN/CvPgNPvRM4tZATYB+e8qTn0EbdJWRkWEucUz1j5Xlh9puQwZ/vUdHxJsD9+uR9nFgNZBEGiIhI1iyc/v4h2XZPUWC1zvgIYfS5Uyzyi2ITAjlV2HcJtpUnrfBsxUgnCPK6N5p/ZY6TPbp9uxTCWZriBSCmS7LFYQT25/FYpLENRSHys96gwyzvhJOvEJICGGx5OWu4MJrpA1OQ0cGZezE9UPfcn5DNK1tPQCCRagJjBqLVZTVv+uriape2nLZ87sa2Kp+wMwHtXKhg3uFR4PUJHnijpF1ovBktx5Rid01aLELfZqEJd4dPZcPuPS1bhIw1s0eDB8UVhLzBnOJsHOOT4AKFEoVvz/R8MN+lWVEECvjG5rZlFttA8Wkz4dljjS6ldENlFSgjsfFEYTed7J/LVPmdh9LaiZhKu6COchI5dkGo5a310HCFmBCo3OtoovCdwIheaozxCYhqcS4HawNwC2WCY3KDt4Qi8lxZ66SEw87A5DSMsgyvUpxhfAbC/pm4wv1gwNUUwrpL2KsIeOIgL25zVcDdptQkmXL+DzuIDpZG+qvAgpYt/Fqm8FUJ0s5wYHnmsmJ1kkgp5JG8OuutiQAouEk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR13MB4865.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(11063799006)(4143699003)(8096899003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?93lpcj3iZpD8gpqPIxF29DK3rCBKI97y0rFU1CxMZyHtJ25RgqryMwa7TK?=
 =?iso-8859-1?Q?RLNFLuGcC3s7cqQraEhKkCxyhKnO6DAKklVpsFF+W+TRomYc8x/2oxzdLK?=
 =?iso-8859-1?Q?GPi7wSdMQI45etTdhXCVJyaAHa484AwS50Pq/MHl1vl5XxbXCSzKCE1Q/m?=
 =?iso-8859-1?Q?i6CKDTlj1fkZDEE48zYMniRKrAt3YJwpctVsaFgqWg7dZQf8l1lAE0PC7q?=
 =?iso-8859-1?Q?3mhUazaFBW6nRpexik3kqXA19Btcta2ChhI/KyK4R8JUZIe9q/Amu52Kbm?=
 =?iso-8859-1?Q?efvncpkCXQtJMoexKFR2tFElQqrED6RIH4DU7EWW+voDH9pRTxzdYXoLmn?=
 =?iso-8859-1?Q?zFqAXyiYGqkqnAZ+w64WKhAAmyoDUV9fpKOI9t3SocmbwjebOvOGkiisJG?=
 =?iso-8859-1?Q?Rpa+T/ho+HBUf+O3ewuP27+Vtire4XOvqTlb8iJDk2yZepVOcGh1zpac5E?=
 =?iso-8859-1?Q?QiXZ+2xog2tFYIsYi+yR4LBK79TDplK8h6vGqbDngvgBQDyKNP51eL395P?=
 =?iso-8859-1?Q?DrveP614Tecn9Z9wtsUg5qCtAnzr8KHBADgTjcKWuH+WJx5+oMLMcJxegG?=
 =?iso-8859-1?Q?eQVuZSxgxDGOtD6CkLYZRGAZ4LAc1xkpyh208cybHHRRAeXfNPNUfA9azz?=
 =?iso-8859-1?Q?dWZbFPqM1A1mF9Hzf73g5D4ChXjmsD7GPlrBmLqzdohUm+y3s/r8ZK+Lr2?=
 =?iso-8859-1?Q?DpqCI48RrykCniNI3reLD2KbU9HkuVeyld4dG7q1aPAM024VnKVusax8QY?=
 =?iso-8859-1?Q?1q7vcEagFwIPu/fsj4d1lVI15Z5nsgAOL1GKWKqE57N+HCoLK7fKdMk3IU?=
 =?iso-8859-1?Q?QTcyUendByZ/dMzMdMHl8d0ii/2fbBrKR+E2xfRk8P8pHcvMJyyYh2j4Rr?=
 =?iso-8859-1?Q?HZHWSEH6rps87+AgwU1xF2prEhHflGsrZ0wmSnjhyjpVaRvX7FazXNsgj7?=
 =?iso-8859-1?Q?tNWun3DyhQCTiTOfc53jhvGDJl6GgfXcX1zNtZvakKz+KxRTF5oIlWQNeb?=
 =?iso-8859-1?Q?Z8HExD0d1mSmngdS907SEeIDJFVKFrxYT4D0Q6PknG/HEn7m0QNOZz996B?=
 =?iso-8859-1?Q?BOBDMbmeeMfi7JHgulv4h/xrYY/H7AnPT3i75oNvr6jVzafMOhFVK41cIi?=
 =?iso-8859-1?Q?yQk6MDanVUjvXV9Nudsfjh03DGxpXlQFDZprnU8CNq0/kpWcbMTcUn49Nq?=
 =?iso-8859-1?Q?qJZ9tK+vDDrcJmisNDZ+YfmSB7SABNyhjasgTZJ3BYrJGKeZ35+YVSm2Ou?=
 =?iso-8859-1?Q?vZyyiwDLHsRfPHoEFxHOyEoIufl5B+htf+O5EILi5SP5MTZWdGRuMjwfxu?=
 =?iso-8859-1?Q?OJ5dcFmbdZCWYQmGzppDUMc/c4R05u6mTAUH/IB+BJXU5+7IfcqYDgyGdi?=
 =?iso-8859-1?Q?5AWPHJYtDz+aeURz5o5T7hXMrauEsnq6gh05G8TAPJEybgmjGVE2gIjsbo?=
 =?iso-8859-1?Q?MqQelyfdf0eQ/8OygGGnOWkCoRmmtjbGlvfzLKJf7a5TsM7/aJY850B/pn?=
 =?iso-8859-1?Q?qwEj/bnUXkx9rG96nqsK97p7dBqlbZ4jxIqyQXjT1fXBshg1hqzbEZNdgY?=
 =?iso-8859-1?Q?HK6j2JvLOWE0aTR3K9Csrbfw+bqvtqoeNmQrclVcIaxxO5rza/ktMlJXYn?=
 =?iso-8859-1?Q?NqB+GcS/bwaHBS5kJP5gQ57094NbPjw6Uspj7gnA7ZKTx77Fl0iUm4y6CG?=
 =?iso-8859-1?Q?euItajRVh1UY2fP+Sa1huSusuYYvL/jiFEjT54o9wIfzus8zCNG9+QJiBF?=
 =?iso-8859-1?Q?sqZKLCI9NUi4y0JMxu1PgLpO5fTSpoQXNT9zfVdXDSVim/MHW1LvMPczXb?=
 =?iso-8859-1?Q?eDxXzfzz1YVmuJnqPMWJzMxYXRhpwUA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BY3PR13MB48650E00DA1B7C484E6BE66781952BY3PR13MB4865namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UhM9lAvE/2s0Z7w+ZyTVve4aQ45G8qWd8ecg3Q/g1/n70dDMUiMpRq7QdatlqWX7CYcjlaTlkb3/kaRABUcpKuRQQQ8mXID1PwdpSnIborcwy5jkhNmgvq5/cwWLvzwK+ZupTfdv1bxsuW+JoyZUpszZxrMoG0QPornRu0e4dYYFMISvrmayA036L4C9Iknu+JObLjJO3Cv8Ow/EEc57nE7elzBoqGCVsYnBfbPhf7Cy71JU9caQpdXKF0nJ0/yaTVxRY+G8yFR9x7lF7drLb7UMEAJEL5CM4jD2EjqewMRwJmAvgB6yuh0SND41ykTTZkIjrmVRXGs1WrUemw2sEQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KTcMYbh8914g8uxs+bqOVYaNolgw1QvaH/3HQKETC5J4Vb1V3cTJ3J50vgP/eFD7KoDyfyymLli+zi/0+gAhMKAbBmOceaiMzpcGxdsYDXp5v6Wv4edDWPHwSDtY2wgBqLxuFm2rYWlN4QaDd0Y22wGANN5Ti+hjA+uUw0uzEMfWaMOYaOWLa6Ra6KpsXG+PwtIsY4WKGjJ2fvbLDf/XC47H9zOZ21ZoiNfBEBuHunvczwl2ESxqdcEBk8FpotcqT/jzYr8BwERwsIKn6S2ju4N9UxZeMc/O/2KteinzD9rL7EU7s3gdZR7acd/tfXR40CT2NFNihHhsJmUJyBlbUkrQmyd7h4OZ+2dNYnIEjwevQRITaRc1VjEbAFEfLa9SE7oG04GnrgQp9jNT4jgKITgOW+rVQzDKoco9MpV2JdHTtU36rWeuJLUWnq+N03lUmo5ee9z/H+ruWRZJG0h8XqBG6oczdqstNhBV1bO9RCeAOyhbyThlB/EUEZ4XpkW7nGhzbBobRE01324OWYHowpRP99xvz9RPzwAfu72tsALuC4vfRZADRKuZ9/FOTfGs6VwSLqroOFF72B4NUI5hjgJKPbJJmNf1dMavasAy489LgSpxTUtoj/B9/19I58wX
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR13MB4865.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b62a19-ad32-40eb-03bf-08df2381ada3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 08:13:18.0375 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qCk2xJ5Jh/gE8UXy0a5bgjxrI257gEfRvyo7TsH2QEjR2RRgu56fVM+MowLCo5/5ZAcOSi72DgQui5DJTcfmIMJm0rsKTOQLSEO1OeT4v/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3652
X-Proofpoint-GUID: _GPiLKQ25KJIyl8Qx1Ox2hh1uLUS7PBg
X-Proofpoint-ORIG-GUID: _GPiLKQ25KJIyl8Qx1Ox2hh1uLUS7PBg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzMiBTYWx0ZWRfXxBuRyxvHPZU2
 cS6BiITXNeXguUqOM+DCCrqGQwNTvLPMZpRtaO8M+yZb9JQumTeUBDweHEuca0v+1N10p19PIMR
 jjwv6SIxfjNMc2nZEq7s6yT++keMoe7stWZ/8kek3GqtQbcXyHEQMRD4g8gasluiEHZJQ79HRxv
 hVLPisRdS1CZ7IzJvTLxiAWeVhYt4s1MLTISXRzyZMnxvZvPw9muFJYNF1rmDIWaxu27IibtYJ2
 PMIUAxj+o8mwIelqZNpOuRDS4nGgQzOrBxZC7iqGUO5cJDexImqCLEtzk6Tk/9Ud1lqUFSgMlqf
 VTkLTWaQyCgpLX/f0sk5TQJUn/0LTzTLi9BcBpSFeG40LZ/E62O50v7G1hG7k7sT5DP7Ug74Xk3
 Wt/Tjl1Eq3HM0pjPIQMjEsM/VW/P9LuGLE2lTj4Cl7MlChSrmpVAllS3jUYokRyJ8STTv2bP4LT
 2l38pDw/sKyMJJ1l90Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzMiBTYWx0ZWRfXx2CFouT8hB31
 UDc6wtKEjaY79BnyBvzW5175wOf8ELFpFBHwjGeN55X4GRQO6XC5IxZfYJTe2JSv3O4wCaTwbGk
 fOplJIOsY7WjMTJsiBPIDIWbvsL6xfgA/C+ugokr14SCd6Pd7YDW
X-Authority-Analysis: v=2.4 cv=abr0Dhot c=1 sm=1 tr=0 ts=6ac4ada4 cx=c_pps
 a=qMfGPIaByV4ZnHoTJsbowg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22
 a=bd-SKr3HlWZVCYFCRTQK:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=QvV3tlCBsf8M7cBNJ4oA:9 a=wPNLvfGTeEIA:10 a=V3dHQoA-91fAlRUJYR8A:9
 a=k0Z6yfLRCYGwlHFl:21 a=_W_S_7VecoQA:10
X-Sony-Outbound-GUID: _GPiLKQ25KJIyl8Qx1Ox2hh1uLUS7PBg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Mailman-Approved-At: Wed, 07 Oct 2026 13:22:26 +0000
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

--_000_BY3PR13MB48650E00DA1B7C484E6BE66781952BY3PR13MB4865namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> Could you please try this series:
> https://lore.kernel.org/linux-pci/20261002113319.6652-1-ilpo.jarvinen@lin=
ux.intel.com/

Thanks, Ilpo. I'll test the series and report back next week, as I'm
attending LPC this week. I've also added my colleague Mesih to the
thread and asked him to help with testing.

Maciej

--_000_BY3PR13MB48650E00DA1B7C484E6BE66781952BY3PR13MB4865namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; Could you please try this series:</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&gt; https://lore.kernel.org/linux-pci/20261002113319.6652-1-ilpo.jarvinen@=
linux.intel.com/</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Thanks, Ilpo. I'll test the series and report back next week, as I'm</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
attending LPC this week. I've also added my colleague Mesih to the</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
thread and asked him to help with testing.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Maciej</div>
</body>
</html>

--_000_BY3PR13MB48650E00DA1B7C484E6BE66781952BY3PR13MB4865namp_--
