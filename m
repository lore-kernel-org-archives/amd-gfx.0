Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F31C606A31C
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=b3UxtuX4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A34210E452;
	Fri, 27 Nov 2026 08:52:45 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012025.outbound.protection.outlook.com [52.101.53.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02DDC10E452
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 08:52:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPM9Dv42P8KXPZm59bsDN4pv7u/iFp88ei9BKJ5UQWLpdkjkUhsFLoEOOiRxEVUu+EsqPYipI9WxZ1rfgi6h2OGRLYbPW/ut26iZhhnEPFRaxY87+q2ys/r4qSR69A3B+Ef26oVilGwtvCuMTNwfECW1L/UWXSiKymRDXJ0iO+mhwAFNMH8cRCQSEihDN7tVfk4fjFJg/7HByqIcyk3YHJL/x7xNBMM8ckaiZERH6GnDWzxUPdTtYxJ4KyyeEB9QwohOqSckR06PpwtUVhtqG3LWs6P31NaPCbxKnjpiQAHmTbSsnoM+2aLJboq6D+xBc887pAxAmxcBwu1KGSF5EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arIXMs4KotEVd4NUORz/WKGvP4VpMjDT4ASRGNzAcPY=;
 b=goOW+2ml5V0I3QXkkuVLvU3KtV11GwHGjVkeVbUR1g/ohA5joKWEPlLqEvEYO1mZ0MPx9i0gkbsXAxcBN8F7InIRH0Rn2wWLKYTaPvs4zYosnJHYhHnX6cEd9L9AMWyRpg+fYK8WxUUh/Lb2qCIkFbTP8T4WmfiqIjh5hVzzbPvkdgqpZJ2gn9aWbj0ougElX4cElKpjRoC0k4L+OjeDfEbRZPTw9wtf467ayGas+gVaOwEUyYEtsoMM5FnjYF/BCxPmWBqECNS2YdhdtVRpn3Mx8ZG+RrQpV62Lx9A6YITzM95QLV4OxebfC9HCrzzWlvoVOVzOMWkBCipSYav4uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arIXMs4KotEVd4NUORz/WKGvP4VpMjDT4ASRGNzAcPY=;
 b=b3UxtuX4tlhCdwCptqQZ3rkWaD802OGT9oom80VHFjm+eRq9zVVF7at9cK6UPhNinUXPs6JhrtK7/YR2pQJpSsAaPo/6NzCcjph94oRr5HXx0+jQquYZ+ExSORprPavb72QDoUsXmoa+fTJWSTAPhTQgGe4V+KJmDXHrX5SJ7Hg=
Received: from PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7)
 by DS4PR12MB9793.namprd12.prod.outlook.com (2603:10b6:8:2a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 08:52:36 +0000
Received: from PH8PR12MB7208.namprd12.prod.outlook.com
 ([fe80::7bd4:6ac4:fd7a:ec87]) by PH8PR12MB7208.namprd12.prod.outlook.com
 ([fe80::7bd4:6ac4:fd7a:ec87%4]) with mapi id 15.21.0639.011; Fri, 27 Nov 2026
 08:52:35 +0000
From: "Stamenkovic, Strahinja" <Strahinja.Stamenkovic@amd.com>
To: "Hosur, Priya" <Priya.Hosur@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
CC: "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>, "Gopalakrishnan,
 Veerabadhran (Veera)" <Veerabadhran.Gopalakrishnan@amd.com>
Subject: RE: [PATCH 2/2] drm/amdkfd: bound the APU GTT pool size by KFD's
 system memory limit
Thread-Topic: [PATCH 2/2] drm/amdkfd: bound the APU GTT pool size by KFD's
 system memory limit
Thread-Index: AQHdfklh+q0Wt/D42k6/A6J0K+dOCrdBnB3h
Date: Fri, 27 Nov 2026 08:52:35 +0000
Message-ID: <PH8PR12MB7208E94C0A18EEFD9B70539EFB412@PH8PR12MB7208.namprd12.prod.outlook.com>
References: <20261127082854.112025-1-Priya.Hosur@amd.com>
 <20261127082854.112025-3-Priya.Hosur@amd.com>
In-Reply-To: <20261127082854.112025-3-Priya.Hosur@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-27T08:52:35.154Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7208:EE_|DS4PR12MB9793:EE_
x-ms-office365-filtering-correlation-id: b1db3f0e-fdbb-495b-f64e-08df4c63c87f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|38070700021|921020|10067099003|56012099006|11063799006|22082099003|18002099003|4143699003;
x-microsoft-antispam-message-info: 6xr/uMNHGWjtqEb+wbwBp41jCQT+I7dfjJaAes4LMLcOZTM1ffkTFO+Cb1U0pYBiKNYCDVe+3Mk5ds/LlVpyCyro37J5tNYC2j93S+kG002VhVJmpKnvitIjWBxJMkImWunnKJ5FE3RZeWiaIlC/tnZ994c+3y2SNV6Mgq9DfyXQsuYDuzOiN6Q8fnRy6vIunCWHQQ9KOKzXjopoHOmc4MnJDOOgLC+jXgy58wQu4SReFHJaXL1xl50P4bSnkWPebCfotXPJwfiuEGDeXszXpklYAF2+d4YsKFNM7+lVR/gICdkcox8j+QlRseB/eJ+I6vUougd2/FCu4MuZ5fhtt2CQdJD8CDJ1V+P1ygQiWAbxO0E8/Ke4g6wAgnr+p80Zj6Yg6B8Vb2zaWHXppjsNrPf3O31+fqUUwf6S0cA6smQ1CuxhtmUHen1J1k/eHHuvlcTBR+j1vWY21+zvxhbpHI8nDgT6HLEH0cxWz38GJvqImJtfZUXi9F0KsQzpBnLyV8Q3/k8QuwKZblVwKwQPL8WbyVSYFmf/ekyVY5LTOPs3q6uqseellx0aJ5nM4Mxtuzaqubjy8l45CSHQwoaZ1scaPQkdD+PmAsC20PstP2qVPI0E3Wb6yczriV9ZX4vLwB4YZXpLZF5fVuOfSHXYmPXFbVtIkhULqZgv6tdkyICr6aIsHzPRo353RAgq0lvQ3rN5vSl2ipwdSyCwFuqt7Wj4zW+20drjV9voaCvpCCm54ybyooLm3RUUDX2cx9O2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(921020)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?V7WCr5hk9xLyCxMcAzkE+wLOYGxu0E4uAb53F81hJOJpOtVwXuVIeD4pbg?=
 =?iso-8859-1?Q?Rp7Epckq2mH4S6H91pZVSi9wLj9fAVC0m5a/fEkn+zL+mniLmRiyupsYUW?=
 =?iso-8859-1?Q?KgDjN/aa4bNJnerjkiSDcErbo+YXHoHXXUpVf3JnC5QamuRznzBPwZ6RZj?=
 =?iso-8859-1?Q?noeGOyMbhLJ2qfdn2foHMRjOrAk3GvXSEzgAftBl0Ehj7TaJwfbtD/6dLa?=
 =?iso-8859-1?Q?fqAzF0MhA6VHdP89KcZB3OQ1UzpcKVIn1GsB69mK3R3v5l+D6dFVlta1gx?=
 =?iso-8859-1?Q?fdqYi1qEgVpyZTjCxjBYIPECWUwcApOtrGUy4VXSHg/tBSF3I5tRFDx1pW?=
 =?iso-8859-1?Q?Cx+uzeFpkfhRY0sn/ka/XDc7XUNC5NaN5fsqypWMEBb7iFZi7Klgu8dUsk?=
 =?iso-8859-1?Q?4XvMV6S2+68wx9sPGR6S0xEkQ5WRhu+lpCWfxuyYaROHXzOgpjFcAsGsz8?=
 =?iso-8859-1?Q?N//kEuknc1OOJX1PSIpATfK7lfN5Xcuy1YhIO5DmGyPLzSXjIWPji+yg2g?=
 =?iso-8859-1?Q?/KIlob3tAqVYq3HSFdvEybZ99a3cDu+5l5uzC7bGE/mgGyGBHRZD8Po0c7?=
 =?iso-8859-1?Q?IOXMrX9QNMv/ACdpJD0VWHKZ7FX6mgNPCQ89otJjMTUFehscZY6Znc57Qp?=
 =?iso-8859-1?Q?zg7cNUneEaUEv5VTnjgaBQNrpxZtS/3L3lohiTj+bSzVFlFC8asuGhvmPi?=
 =?iso-8859-1?Q?7WeY4bn1t2V63L1OCOdgLxAa5e/92vBGM+Pl5Mqlr7DRL9CkNQhIRTr5Lb?=
 =?iso-8859-1?Q?PWMWjWuASIA9V91l6DmrVbFsKJTqVzyxCSFb41miKnMzD9zOtxxlZ52OEN?=
 =?iso-8859-1?Q?MIAuOLkBfeidcjZLJu6yFXADemahIrPBtV4PppWDt7zUE0MwG1sN81dQrv?=
 =?iso-8859-1?Q?GwDsXSE9G/cM2uz8AJFJu5jHa3XxPOJ9zk+LAWzzyeQTtjc9OxadajPgWZ?=
 =?iso-8859-1?Q?OQCevwzsDv2uJhV+8mS20AJ8tvIvqMBA1f0g2tPYYDHEzlgNhwJQZ1x9Ot?=
 =?iso-8859-1?Q?NKNa24Xg10be02huFfmSeZFDIRECLwZ8mNDUMzUI1iISASlTB9AFmDeEg6?=
 =?iso-8859-1?Q?3jmBHguRoR/xq0SZcUpOh46moF6KOOpo/mDrzNrF2L3ew/sfzJPYGXf15k?=
 =?iso-8859-1?Q?P+n6LtJiKAeWwu4d0LGZApOaP4Se+Wy0K4RFSGf0IeGoSqhekp09o+yJHy?=
 =?iso-8859-1?Q?9O8HAkEy94HSKkzuH0lm21e6tPaqvfTxXYtc7c8fOrOpFatyJSO8Vp/Lf0?=
 =?iso-8859-1?Q?qxBahN/f20TqXwp3rwI8MzauXdvYIQvxStqREveJm28tu4zJagFL6wu9vH?=
 =?iso-8859-1?Q?FNxDemDcZg0tm0e4hVdAopR0i0nI4cNCHimcfdiVpDr3uSQYLd5ywZt9Xw?=
 =?iso-8859-1?Q?k/Nk2ic+h8Pw3mAPcxq4TQVtCjrlxn5rqIDQX2w0ODo6XH7Tkfkct4vBMu?=
 =?iso-8859-1?Q?TMU5IYvV9N+N3WMhR7SsytWgRQCHaxPf70+uJt4TRrWUVfQEHCTuMd9/R4?=
 =?iso-8859-1?Q?CurNss2VodHM+fAGTOyrDh3a+8qJqnrioBNJLXKhBeJs5BLNir4M4qzR4h?=
 =?iso-8859-1?Q?gow40nvjtjCAvsZKr543RgI2/xW/Dyh3U4xvV7sKEjUXmGjjnyccxZ27fy?=
 =?iso-8859-1?Q?MBsYjBDbrQmBwxKRX/Lgp7pruWThhv2t06QTY/+F1jPepFpMULBoOvdzwB?=
 =?iso-8859-1?Q?e9ZVeXCIAcZjXBnVgnLQ06iR/keJy7WPTAAiUgd0ivIVvZnXdyoaZX8IOl?=
 =?iso-8859-1?Q?kPoDWTBJsoQUmkKho3pQFgXrDgA0+a4j6TJSgxUvydt3IwHEUhzEghSBZG?=
 =?iso-8859-1?Q?ofNh+BW94A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1db3f0e-fdbb-495b-f64e-08df4c63c87f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 08:52:35.9026 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e9z+YS0HhSD+/Dyw8WpEq64PL9tnrs7H9p6hif98HUSYJiXGv/yZSDJvHtd1thHOh9pDwxPDlztnzbnww8udNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9793
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Strahinja Stamenkovic <strahinja.stamenkovic@amd.com>=0A=
