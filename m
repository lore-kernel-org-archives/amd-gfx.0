Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1070BCA0EE8
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 08:02:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89CDE10E436;
	Wed, 17 Sep 2025 08:02:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kYP/gUgZ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011047.outbound.protection.outlook.com [52.101.57.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27EDF10E439
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 08:02:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPpEbdG0riiUcH4QFcM2Prf/ePt16q7LKI18eng7Vdq7hBhn56x6iXbPCLzI9gA+5WN1Awef3jJvwuCH50rHSSe0b5IJ/sJazZM84KSIyDPADCK+ObNRFucLWxwXskBMtQ8KCdr3DH4dfnXLO7b12ODqpTq9xl1D0m5qjVvt1U8T3+hgc77w1NnyuzN5iF5mtX6FpOBOJ1its67yyU/AGswg0fPNqYxiYaSvZiD++7qC4Hg8tBbFLiKRG5xB5ttMZdmXLd+1Vyn30slwrYSA/SUwDL3jLcR2taw4y97hoZIZvynuXQJZmFZJTFtTqcegsb8I8l2Gm02rbE2ZvueKJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2PvCHxecDspjEGrvnlvEyEN7fhvOe0G6Sl8UN4vW7w=;
 b=Iu1kq6CPRtTQUrYtIPc+vTUhCNjxL5Qy0KtJR6If7reOCZwvwj+9fHiNg6ZT2I/yo8tqpI/NsAYHC1pZSVM+wMMqOaMP2TzC0o090IL37+/rF1ZCnhfTIb/aCoBCJHxCK7TNrVvqiE/LEMspFQaajgWvleUvqXM4YVlbCTV9pbEDOHVMvGXounS7OYHAoul9FyMa/lX10WVLH3wu0A88wzhsBnoCygn/hFgAO0P/32Pui5sVZfGg2in8qdIGcE9aoPMMgw+lfkAZO5RRNrFg2q9686Uy1UX7HlWZzOOUP8fX7nILbH54KEyiAnrFXAHT9uJUDJKOHej5IfPb9sJrgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2PvCHxecDspjEGrvnlvEyEN7fhvOe0G6Sl8UN4vW7w=;
 b=kYP/gUgZRtgE0P1aqZF5JPb5mICnE6QxP+rW2EOF54yf0KxStBsFCXyef5uwo8Ben6HlpSiTDVPWLGxAJ+ox/EA8J7gZJkuUYnLkW93grTWYRE0lBZXbwRyh0kvudsDkVqon4JGwLErvpPPLzT59VwtDFCMBbru5Q5nlFWTgJLQ=
Received: from DM4PR12MB6064.namprd12.prod.outlook.com (2603:10b6:8:af::12) by
 MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 08:02:28 +0000
Received: from DM4PR12MB6064.namprd12.prod.outlook.com
 ([fe80::e93f:e797:af10:afe]) by DM4PR12MB6064.namprd12.prod.outlook.com
 ([fe80::e93f:e797:af10:afe%5]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 08:02:28 +0000
From: "Wang, Joe" <joe.wang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: add missed PRT flag back to gfx12
Thread-Topic: add missed PRT flag back to gfx12
Thread-Index: AQHcJ6kndgRINYkHuEmu2at8B4kTYw==
Date: Wed, 17 Sep 2025 08:02:28 +0000
Message-ID: <DM4PR12MB60644B81C64090A93DE19AF58C17A@DM4PR12MB6064.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-17T08:02:28.018Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6064:EE_|MN2PR12MB4437:EE_
x-ms-office365-filtering-correlation-id: 51025d20-5276-4b62-8e31-08ddf5c08bbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|4053099003|8096899003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?WOery8Dq+lw5rOH5JeOg3aSTUKTuExbe1OFuHGxyjiCf1Qe5/FY7c/ABHF?=
 =?iso-8859-1?Q?cn9/tGWchGUL2ddGzJx561Odw+XGJSVrZCmQRNhPEsFdRWHp86NIdOfFqp?=
 =?iso-8859-1?Q?837JpODq33FC6G9kcmv0zBzRGzeSi2y6pqQnMXm9fFUe40/Wzhzv6yzFyK?=
 =?iso-8859-1?Q?RYaqIysHdFLMGo9sSkwQ3DrF2GKS+qrGaWSTNuNLLveRS9vp3ZhtV48a6n?=
 =?iso-8859-1?Q?uMxFpPttTTxskGgYLYyQiGLJOPKjY2yfmBL7Tsz5FDUVQfjMDPDZ0zjNQC?=
 =?iso-8859-1?Q?2IQiBEz7xzidSbrmYVti6C0iGb6AbrZ6sL8pw/i1cXx/2fnr5lmiEPT6SF?=
 =?iso-8859-1?Q?4cHFOUmtikn6E9sG91AufMjQ/JG6VnsQbGFn+//MH5+A+N7CCSqx42rVYr?=
 =?iso-8859-1?Q?cr+3Dn0CHrBSs4ktoAySkDCanlhKzisY7W9lrNuLx8suGBWSMhHayyHfim?=
 =?iso-8859-1?Q?hiqzSOtYCGAV2hTzFoKZHBVzP1ovXWkNzsQTcK1MQBC5MPO1JxRpFpyzRK?=
 =?iso-8859-1?Q?RM6khfvgwcG1z0DjUoToFoMgHgvE/8TPb0q/3cYGrrbz/EsssSyWOUCLJ2?=
 =?iso-8859-1?Q?PIfWg+8e4DOhGMiPiYh/x7WT+aFJie+ZRutMu1ethO/l8z5iNvMpW1f6uS?=
 =?iso-8859-1?Q?uwHmLpAnXGAWFoWNSxzdAbxwkTFZveclsscRrKIew8Rok1c9l6kcsHltMA?=
 =?iso-8859-1?Q?2YuXZ209W1x172ZLoKNnAYO1XARmC0Vq+PIbQagQH4S/DBpjLgjyC9XRdx?=
 =?iso-8859-1?Q?wLaeGKcZHKtIB8wVniETncwg/Zrvfc7ayweiL5jIGdDLhM7in5/NIYpprW?=
 =?iso-8859-1?Q?yymqhwFaUNIb4kF/8CuLYe7hN/L6Hu2PkDf9DvgmpOnKbRxGeh2/kdoea7?=
 =?iso-8859-1?Q?qi7mzpbhI9V69r85DzYWAVaLnHxDAqwH+dfzneiFFGgkdASHln2nShNOcz?=
 =?iso-8859-1?Q?Mfa9xYj86U+0MkmeGXTeT/WErRLzJ+1/x20fqqhXHLb3gEkNXTvFT5EuqH?=
 =?iso-8859-1?Q?jUYXatqwd2EfKJRoBL/HzLAMFxrlpMJULsE8NlC8rGMsOkOYYaPymeLQOF?=
 =?iso-8859-1?Q?lKUXRvPW1goFgFnfPyJzyFTZFk/fmQ72f4Y+/25wpKQ3+w72myKf6p2x4N?=
 =?iso-8859-1?Q?AoOe6MA4q9PqK9/bcFNlg1sHnnN0h20MQDrytpJC993Qw4IyZ4Iy4CwuDZ?=
 =?iso-8859-1?Q?DoWVLZr7TUTEphkYG33BPgD7oO4qm+T5LRgxd6I3UBhAM4S0xHPPNxWyH3?=
 =?iso-8859-1?Q?TuSB+yvvA0kMVjJmOUSaKbu6JUpi+/962mFwp+gU5vIy/GwGd/EopE+jCA?=
 =?iso-8859-1?Q?n+oc8ho9g41eWgvztTaiLQenJn3HtHiohIn7cVXlsJ78sGavMtvBlVjt9c?=
 =?iso-8859-1?Q?g2lwogTG0qowZOvRENMvOVin0xG7MpVv9QV1B7aaLb8WkNtjsxdvGAhVVV?=
 =?iso-8859-1?Q?T9RS/1E65Cv7rFDnBHTnPatT2xeqwtTyYFFkhivXltskUajB5QS9KrGgAP?=
 =?iso-8859-1?Q?azn75mTocaKfca4UnyrYOl47LtmE4k/DVt0zmk+4WD7PIpX8exZRb/CgaV?=
 =?iso-8859-1?Q?GRH0deY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6064.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(4053099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?toEIBkTs7NOuyNtMjTl9xEaui1mQZrBNPTAkcgHDvlcQ8GvTyzZv7L2Pha?=
 =?iso-8859-1?Q?M2k9QEVJB3NHxZHx+XGKfgH9R/P/K2SLBWu96j3qyZkb118M4Dc7JFfMVL?=
 =?iso-8859-1?Q?IqOqbY9JA6XAy8gMwIgqsrRv/efOzyoZ2o+HY3HNoIk3iXPy0bi10iGaF5?=
 =?iso-8859-1?Q?iimxs1c3dU3lcE0MVP+iBZtj7xAqnVzDjA0Gj+GD4rON2jOtw7nZ0C6G7Y?=
 =?iso-8859-1?Q?OZ+eNFAMk8EF+vMI72cGOzXp9MHksaIvGGwFmiX1UhXwRA7d/QGLRWNg/E?=
 =?iso-8859-1?Q?5ZyFcVmBKVtgsTcjcRMzQCA8iDUWCXE1GYekuXEHz7sv14BPs+yuPW/Uod?=
 =?iso-8859-1?Q?rAV8jXoveqIz6K9Ut+JKf8KT7kacf98EvD0gLapZZoShlDvsFgZP6SP/gU?=
 =?iso-8859-1?Q?Vw5eOWDtg6TGhuOobdRTogQ7HH2AaZuwG1zGej6SIwe6hWLcxErWJv3KTn?=
 =?iso-8859-1?Q?SD1G+p29r8edm9X27iYfR57dNn9Yk6wbAqoXfD8gmLHRcAPT6DMKR2tfS7?=
 =?iso-8859-1?Q?5xmtIte3iULg3bgEMwuZRWRwc1cQQ1g8drXI9+O7sPjxpi0sYaw678FOmO?=
 =?iso-8859-1?Q?Bax99PQKlH3EKakh56Cl5SojQj2/zeVgmjD1w0CXbOeQIPe07RTyoIk5o/?=
 =?iso-8859-1?Q?6NyGftSQ+wBVnGtSZZJTXtfVaSRu8cbg46q/upkVoFXM5F+xAhi3cJddte?=
 =?iso-8859-1?Q?5TcQpiYsTw0szSZWKJgpb4q8ZSieUAq4oveJ+UlAgtBbVO7gYaXR1YOMi4?=
 =?iso-8859-1?Q?H2zM4okUKLfNEBKhXqpfjmS/ikqTXoGlmtBccYxXa0Wfh7etnOQqSRqaYd?=
 =?iso-8859-1?Q?vzQwAUupIIesB1jUpPC32R7p767J8JQzZyMtR74IMPRYrbNC7KXHD8SBeG?=
 =?iso-8859-1?Q?jLpWp14agaSvVCSw8w2bbbhNZwTNftzpag1A6+RyXTCcwOX8B+Q2UHXwq2?=
 =?iso-8859-1?Q?t61oVQ7VLh4jBoV6mv4rSHyIfr3UXfHdGXH6HiRiPZaipDZFySYOM/j7U2?=
 =?iso-8859-1?Q?cahKxuWQkLprcP+XZoOyMXGIek77CzFQktV7jORWyjnG+/2tY5+zMrhaG/?=
 =?iso-8859-1?Q?0Z0MWtkFm/rhKYjPazqecDSC9yY1UHx8HnzhHgS+cwvoL+LO4lhFR/OrL/?=
 =?iso-8859-1?Q?iFIGUs4exzFLIp9hWzh2y0+5Xa8fx7lR4sYO+NmlcaEPsjODvRGO1Bq+Fb?=
 =?iso-8859-1?Q?bkTQzxOdtZ1F9Orcvwa2idNQmqroMAn0u51LR2ee0hpJ5+GLvJx9IfrvRz?=
 =?iso-8859-1?Q?fEQ/kAzIema+9SPy5YOdBu+LvYAHVLAm2GKLhrbNKnWrkwUxN5UNWEQzcZ?=
 =?iso-8859-1?Q?wkfosiiNd0GGnrENozHjTx9sL2AX6ebQo68RB+0+FEpCJhZSfK3UIZw9M6?=
 =?iso-8859-1?Q?B42zrmGXMDtWQeh9Ll2LLfyR1L+tXqcvh8LZ4OLeK5oJoA5fzw3Pesg4B0?=
 =?iso-8859-1?Q?2MK8CEY3HQKyB8DiZZgEEFGS+ddZAKxb1sF5qOu0K2VzHwwIeioLDD9C7y?=
 =?iso-8859-1?Q?o1U1Bj0K82fY8vz8XDf2PJVc7TufhehBOXrdQZUZq2qSlgZxxTaxirEgVT?=
 =?iso-8859-1?Q?wE92sRc1WROLho4RQ8Alk8UHkpxZkFJqwYCmK2jdpRVls2MdKnF0j9jppD?=
 =?iso-8859-1?Q?UV8Fc+RIrsQZg=3D?=
Content-Type: multipart/mixed;
 boundary="_004_DM4PR12MB60644B81C64090A93DE19AF58C17ADM4PR12MB6064namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6064.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51025d20-5276-4b62-8e31-08ddf5c08bbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 08:02:28.3339 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zjf8I3rzHqYAQjq5gqCOigSs2jWu0I3gfGZ2T88Vt76uL4WP1jekubtZfnGPEOuyINT+oep6HJFdMxZrm61Qxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
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

--_004_DM4PR12MB60644B81C64090A93DE19AF58C17ADM4PR12MB6064namp_
Content-Type: multipart/alternative;
	boundary="_000_DM4PR12MB60644B81C64090A93DE19AF58C17ADM4PR12MB6064namp_"

--_000_DM4PR12MB60644B81C64090A93DE19AF58C17ADM4PR12MB6064namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

see attachment for details. Thanks.


Best regards,

Jun Wang(Joe)



--_000_DM4PR12MB60644B81C64090A93DE19AF58C17ADM4PR12MB6064namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
<div style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apt=
os_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);" class=3D"elementToProof">
see attachment for details. Thanks.</div>
<div class=3D"elementToProof" id=3D"Signature">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<p class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;">=
Best regards,</p>
<p class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;">=
Jun Wang(Joe)</p>
<p class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;">=
&nbsp;</p>
</div>
</body>
</html>

--_000_DM4PR12MB60644B81C64090A93DE19AF58C17ADM4PR12MB6064namp_--

--_004_DM4PR12MB60644B81C64090A93DE19AF58C17ADM4PR12MB6064namp_
Content-Type: text/x-patch;
	name="0001-drm-amdgpu-Fix-PRT-flag-for-gfx12.patch"
Content-Description: 0001-drm-amdgpu-Fix-PRT-flag-for-gfx12.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-Fix-PRT-flag-for-gfx12.patch"; size=922;
	creation-date="Wed, 17 Sep 2025 08:02:05 GMT";
	modification-date="Wed, 17 Sep 2025 08:02:28 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3MzI5ZTZhNmU5YjkxODU5OTQyMWIwYTM1MzU1ZGViNTA3NjBjM2RhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiSm9lLldhbmciIDxqb2Uud2FuZ0BhbWQuY29tPgpEYXRlOiBX
ZWQsIDE3IFNlcCAyMDI1IDE0OjU4OjQ5ICswODAwClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdw
dTogRml4IFBSVCBmbGFnIGZvciBnZngxMgoKQU1ER1BVX1BURV9QUlRfR0ZYMTIgZmxhZyBpcyBt
aXNzZWQgZHVyaW5nIHBhZ2VUYWJsZSByZXdvcmssCmFkZCBpdCBiYWNrLgoKU2lnbmVkLW9mZi1i
eTogSm9lLldhbmcgPGpvZS53YW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ21jX3YxMl8wLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTJfMC5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMl8wLmMKaW5kZXggN2NjMTZhZjE4NjhiLi40
MDRjYzhjMmZmMmMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192
MTJfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTJfMC5jCkBAIC01
MjEsNiArNTIxLDcgQEAgc3RhdGljIHZvaWQgZ21jX3YxMl8wX2dldF92bV9wdGUoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsCiAJCSpmbGFncyAmPSB+QU1ER1BVX1BURV9OT0FMTE9DOwogCiAJ
aWYgKHZtX2ZsYWdzICYgQU1ER1BVX1ZNX1BBR0VfUFJUKSB7CisJCSpmbGFncyB8PSBBTURHUFVf
UFRFX1BSVF9HRlgxMjsKIAkJKmZsYWdzIHw9IEFNREdQVV9QVEVfU05PT1BFRDsKIAkJKmZsYWdz
IHw9IEFNREdQVV9QVEVfU1lTVEVNOwogCQkqZmxhZ3MgfD0gQU1ER1BVX1BURV9JU19QVEU7Ci0t
IAoyLjUwLjEKCg==

--_004_DM4PR12MB60644B81C64090A93DE19AF58C17ADM4PR12MB6064namp_--
