Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DFEC83F17
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Jul 2025 08:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4F7410E258;
	Thu, 31 Jul 2025 08:34:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SBo/YZTy";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91D7A10E258
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 08:34:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akduWm5sYTihvq96C+xTj43orQZcgtkzL0wow+wlvwo4o4fbhSr596rgi7aE0uoSq/UMxCYYhnEP/lpC3AXfjTytvhU0/4ADKaR27OrZBDLMjgvfWFSgY9dvBu8AkmV3IQKd6PHKRbudz64H2YhIs1fK8Lloe8t7BieKoikcQXJm1HqwZSCTMGzLVSFKndSwLlxtHZrQPuj7A9dUAJaCxhI7XQW0uE0emmO/rHAN+GbF2WpnqbjuGORPD79U+xdZ2lICsDaJOxjWgJUOrs8YZKBnHgk+UUDInmsEP8P2YUpWp9SQZK1bUj5t+pEL9X6w6APVgJnGSu1c6dxWLhGsig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldHeE/UcYogfVCzyqMKRmmbjyY8fBwisV74/qBm6tM8=;
 b=R/9jcwY8wd8mnJ7lS9fZUhv9vR4jh+xuaPo2pIjnswkPiEnHszkuWNpvtZe7lLcO+oUpCcGgo7ZJ8GhRo0Iy3MTzeljCjbTgtf2bNfswwPwamGZ9tIe9yAtRfludhK2IET2DU++fAcgOHvyCuv9RgSqmjezu5stsszJmQafvdU2nutOT0KnaM1QOmxDawPZukn03Lj3ThUjVwgzoql/DUg2gmNXRZiN36ynf3rcYBpI5gBGynDDAi/K8CLUVi/jhQXKvH5iaLIx/hoYdiUBk7QLMo5BjjmC2ecSzjUrGDrmbRtT0+glBqEDS29/lQiFUkEA+zg1izZqSJIH/p6gCtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldHeE/UcYogfVCzyqMKRmmbjyY8fBwisV74/qBm6tM8=;
 b=SBo/YZTyIvemA5+/fY45d5+74yyKTjz/vhp6MC8dP/nYNs/S8xjVD5e1IxfGe4jrZGz0J3QM23IgOMZYbEvWDxI7RiMf+Fu09fuHBbvHrJUP6KHKQ8ruSo9+NuqhhzhKvkTvZXzWSF9uwLqGhiISyTn6Mr+iwRtZeTfJfk52R4M=
Received: from CY5PR12MB6432.namprd12.prod.outlook.com (2603:10b6:930:38::8)
 by MW6PR12MB8835.namprd12.prod.outlook.com (2603:10b6:303:240::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 08:34:30 +0000
Received: from CY5PR12MB6432.namprd12.prod.outlook.com
 ([fe80::40e2:bd67:24f9:7fca]) by CY5PR12MB6432.namprd12.prod.outlook.com
 ([fe80::40e2:bd67:24f9:7fca%4]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 08:34:29 +0000
From: "Zhou, Heng" <Heng.Zhou@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhou, Heng" <Heng.Zhou@amd.com>
Subject: Recall: [PATCH] drm/amdgpu: fix nullptr error of
 amdgpu_vm_handle_moved
Thread-Topic: [PATCH] drm/amdgpu: fix nullptr error of amdgpu_vm_handle_moved
Thread-Index: AQHcAfXuqEhMzCNAX0CpbEpjnRCzgQ==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 35
X-FaxNumberOfPages: 0
Date: Thu, 31 Jul 2025 08:34:29 +0000
Message-ID: <CY5PR12MB6432A2B11E769D61B31FDE17FF27A@CY5PR12MB6432.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-traffictypediagnostic: CY5PR12MB6432:EE_|MW6PR12MB8835:EE_LegacyOutlookRecall
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da305fef-ea99-4a60-5827-08ddd00d1140
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?dW9TpFPBW29TGQURZFK1NXDGBFsNzy4tI+rqTf/qFZVJ/fs8dTcnRCCe97Qq?=
 =?us-ascii?Q?uBaHs6V9re32tQkobWTIdj8/coT7K4BR2GYmag1rSo0Splj/luD8R9sYoDY7?=
 =?us-ascii?Q?MoKyCDyxlpMD9bBaWOqQMHSQVGWG9CRx9qUU+Nh/aH7ocSIczn9T13Qy9SIp?=
 =?us-ascii?Q?pBCg42DKmSuidXVFdmYLmOJpZ32tMF6W+56XNkYKRBLmpYCTdjxhJ0j6S2Kp?=
 =?us-ascii?Q?W9CFHivrOLHtqUmeEyYbObvDYArOc36adoc2pctAq6zPHjFS1FqLzApBfV4M?=
 =?us-ascii?Q?B8wFGbJj933y1HLWHBNJQGGxZ0etHA4zGKJoa/XaEXHwonBG9wpeyjP4AHkb?=
 =?us-ascii?Q?T2IKo0k+KZXbcHzmYm4JPPfDP4sWfSyysQZSKgO8SqBMVEPBH/TFvwDBDtHH?=
 =?us-ascii?Q?MYf8fe+APTOBh/sgL5NQ22BL7uY6TgGUgJnzFCLTvBzRgCg3mclBIEVG8Iqx?=
 =?us-ascii?Q?lRtPFE4TzMizEJ5xlNqltsJn+Jmtwv3Fl4P1K8arnhXgB7R7kdfddEIuQvTX?=
 =?us-ascii?Q?qM4iAvscdG5czdOqBFz5m4FmeYcTUBADwSPXgR/5mii1WxNFpewwIEn5Dm3k?=
 =?us-ascii?Q?GIjGIpOEyH+HPzlPgPUEQssYVdMXlG40NF5LU7fFTFnEHlwKIsyyrpXwcBM3?=
 =?us-ascii?Q?ZAeesGtZ4dSQKZGn2YYLiKpwvlPn8qy/MgC0gqWMbK/Qk5SdsZLEq9BU4qxG?=
 =?us-ascii?Q?0Fs3BxhUOlKygW2pSAt7wmobU/jDI2DwFGh1vgApQxlo5cmZPSISKL/c8TGH?=
 =?us-ascii?Q?KHlvBReyPoUGCz8eBRnqJ2lpkw2N7fTvFz2ValO6cnR7UrwZXVL0uVmywT7D?=
 =?us-ascii?Q?b9LzWZDcVBKTBQRQGWi2kJdR5jPmFGOUK1DDutMEQmrOAk4jjnROsOx8fvjk?=
 =?us-ascii?Q?e49lAVD/J3cikfj/cFU1//MWsnE1nuYCud9c/padgvJFo3N9AGtCKoOaRdAK?=
 =?us-ascii?Q?JxQKZLDyBxqiwEyaZMz4Y5AU7iW9pKo440A+0Ffoc9e+jxAHOqn+zht8UM6L?=
 =?us-ascii?Q?MuViybh1/PL2Q+AyU4Mu0IIqLA9bOA0Yz104V/gEMp+fFAo2O1GwwPnh+hbT?=
 =?us-ascii?Q?q6sJ4xIcpH9R2htXjteIKyiaK3wtRLrsTT8ZgRz+1p6GO5HZsDWHgAfDaNRz?=
 =?us-ascii?Q?r43drIyLllD5i3dvJ07eVtdSQ5sEidAWyuYmWjb4JvJD+y3RKSNPEqLJEZSp?=
 =?us-ascii?Q?2Dxqzyf60KatNCob3zvFoTD9cdBFRjzuaunI3Rm7sy6Wc5zs2cdgYRk+DyHN?=
 =?us-ascii?Q?UZF3tYAhE/qUgDy76LfwkH/gwQ99NOq9Au3ATUrk8j6x+F4eJ+G1GdNxVrXB?=
 =?us-ascii?Q?MF43WccpbrRAnzaPW5E/F3Xhx4h9PdJMS4kEilq1RpUjN4klQz7jI/TzKbA2?=
 =?us-ascii?Q?RBd6anm5A9e0TeUVUp2xd9WEuDdHGHRHuDTEGeQdX05HHmT5veQ1+R2j4f21?=
 =?us-ascii?Q?PQm+TO7njiP2d5fPCU2RRF8ZU3YlnXhd3ytVuaH67OpCmArMXQus6A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6432.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B/Lmze9dVUa85JcTUo+Cj/VEuAzgzjfB2qbAg94WnzpPBMFGy8b4ibHtNy6V?=
 =?us-ascii?Q?hbnAfcAXl9JGWkLOMcmTXZwl6hYmH9djdYp6Lu5ivJKqJ/CYs1pHp9HkxivL?=
 =?us-ascii?Q?8jdw6ata/WrC0/5jO9A11/+6nEN2tum5aaBj1L+O1pFODKzs+OsuCoIogYlU?=
 =?us-ascii?Q?A9uQ8ls04naPqiZzoI8ebbuNVAHZF/n0x0qvOm4eTJdEmxoS1wOkj2Om8Nx1?=
 =?us-ascii?Q?xud3BLJYLvyH8oPpyo/4uXO/Xv6Zz6RCspTj+4ZjVQF47p1ZekB/lGhKT2UZ?=
 =?us-ascii?Q?arN1nJBSc1I9Csgnrknin9i3EcwnYdLORcif0l8zE55QSWPl6y9f4zjHB60m?=
 =?us-ascii?Q?lMjOoBrvTszc0jZj9oO6j897hJrd+UnmAemGEdXgN3HN/lUvbbuftqtybZO1?=
 =?us-ascii?Q?M0nwI5a+TlIMnQJvNbLXBaZ09ZfKg+A9YI2TQaAsvivc+d4KzTQTootAO8gF?=
 =?us-ascii?Q?McCiKF9s9w6qPlBGxPyJlMCANU2iG/4vAe2+TVj3DQ7zRzGVxQv0I+y5NVpZ?=
 =?us-ascii?Q?Bg/P6o/GtPAunk4DSRtubXmRmCfFqWbRxOGTINyGVJ5aNyi2uQ9UIsKyc2D9?=
 =?us-ascii?Q?67yQYHRO4K9q4PSHzOUzaoFsR4KrenHrJsZ2HLEcM8T3LwCQNqOWy4OWLR9O?=
 =?us-ascii?Q?9y8ozcvVR8YrWcY0+MMBbvkBQV1US+Uz65aQaA4X1gQeIFiVrnZead0ITwGz?=
 =?us-ascii?Q?YofG/Tt7N3WMPzPI98kBRgo4iYK+106BMNFsqW6pasBovbniJggeiRvT8ov2?=
 =?us-ascii?Q?oGS5yH9BpGgwVFi/2qxZnijcKiQPveRKbZ0whC/hvHBVBsTSQ30AatZNF/KP?=
 =?us-ascii?Q?Xtw348/XaUFHnBFiO3HPQTAywh31m+nx1RTobT146nLOcokVyrhM96wJW5Or?=
 =?us-ascii?Q?9/aGW/bghblk2nOmQI/nNEb7SKgGV5BQRJ96TS4QqH5XrI1sMiWr5IYP74in?=
 =?us-ascii?Q?Wgj3PhtV8LKIbeZER5n8SpqknpTobLU0Se1/5BBKt7nrcvn1q25O+V3O/EUb?=
 =?us-ascii?Q?JfHansWq4toihkC9PPHuUrQugjVjFiYbGGXsiw1lc1Bw2OaFm9xfu0ArF1aJ?=
 =?us-ascii?Q?eS6AY+3A4t5DvusRb9Jxx0Z2dFuFG0O53sNhpzssZKNkwzsU7s1SwZgjvPdw?=
 =?us-ascii?Q?rZ+Y5rk6OV+gV/7g4H+91IftcvRGQcDYJTCfWLbDKCHo0wbJ/u4gaL3EfIG+?=
 =?us-ascii?Q?hmJ7oGH9G2l0cUwvPiRCavOqg2UII4pUa/Eypzx1tcbZpGzzxS+tp0lEUp71?=
 =?us-ascii?Q?4abdAO77A+sFKcpnpuCg6B/hl/vvuCChumLzedQMp+L5/I1rQsA9fzSSAePf?=
 =?us-ascii?Q?7XOwv1Sgw8b2eLN8W2BIQqj5iaBQaX3+cuNT6owLwuvPrshc/kmQwEdoijZd?=
 =?us-ascii?Q?Ocf8z4dnzfAVQ/G9G4HHtfj5V617ZoZFxMUg8+DO1ewGJy5bIjh2r9rvan0I?=
 =?us-ascii?Q?cK+Z86svcSfjmRPN4xTHJUcqs3SeS62tbL4In3NviZMO6OC5h91VN3Tyktfj?=
 =?us-ascii?Q?o1veDET+SnW/PyScd+UhNWAIz+FXo7zZVfnDx+rd/p0/vOoOSOqV2oiAwSku?=
 =?us-ascii?Q?seLtpkpVW1QgSuitxxI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da305fef-ea99-4a60-5827-08ddd00d1140
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2025 08:34:29.8761 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TWS8gQYgrQHEnoH2vPAmaWjLTofp70KaOpr7aaxjWgNzA0Kk3naF2EhIUpGpQxIuhA/8m9ng65ztThGDViFyhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8835
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

Zhou, Heng would like to recall the message, "[PATCH] drm/amdgpu: fix nullp=
tr error of amdgpu_vm_handle_moved".=
