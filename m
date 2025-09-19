Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DD5CAC592
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 06:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3995E10E226;
	Fri, 19 Sep 2025 06:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DZEKMPhg";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012037.outbound.protection.outlook.com
 [40.107.200.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB76810E159
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 06:44:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YO/vZaDXcxlt0YwZa9HMHyM09kaB5pBabRN9rC825izxnpluEOyEg69M2VIsFQdW1PtDPVUqwz+oBlRZwUnRO3LNTegQXiDs15gAmJyeCKwZ73HAFzPEPyNEPGBMe4NEil2Ei+n3WjJL7BL90SK0fOtbMfYKYfdwfgObM/uKwpTu4HNRRV4oRFlUqv45kp+ctMektEkrcxSmzvoXWiZdI+e4+njvk12stC3eWNIw9sa+XSSG2qdwy96uss4ha/UZJ+HHIFci83nfVduEZ7y2qLvHKWymDuguRByo+mMyQIVvptMjm177tzHZWTEyE9KlD/rIZwCxJo1in5hGjCMbSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIYGG/gQl2Nq/yEuesf9ytJzNCSkFORUBDscBA9KVW4=;
 b=m6DYtNgEOgtWIdNoPOlddAU34zohpYbL2k4/7BOuSYy3yInWf1PaD/n91yVj7pmaHElOElHFq+F6CK5XiTpqHWAGGoCogb6l5bk9nnjxfcTpkwksNsNOvW4+Z+iD0eEInU3BXXm+dTk3d/RaRUV/zNp2HlCgrxLv3unqphPt41v/LnZpolrpADAXW3n2JqMub+cpp9v4S35ctwwTe+ton4PGokyukMOzt9vZVoGa4T74SBkZ2Pe63bpG+7StaYvTzee1X0eBD3mBcyJSapsaQVL+gkhULQxzPGZ5YZHPNxnj3yStV4/wfQy++M2ap1diu5+Sj5yaWpZzJ8VnkOvhYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIYGG/gQl2Nq/yEuesf9ytJzNCSkFORUBDscBA9KVW4=;
 b=DZEKMPhgHPtuYJ5O1YBL8Utun3CbXr0K8JSZjP/pbqplKv3veGX8uU3VrOcLzjYnw8ZU9M3yYlbQu/cNdongk7bHPlh0Mfq0O4pZabzuOeQtjixPhezVeoy3Xn0ERV4IGuKu6FGLhxMereXvGEHgAntRSwqNTwBmb+oHUUGNq8Q=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DS7PR12MB5792.namprd12.prod.outlook.com (2603:10b6:8:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 06:44:25 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%5]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 06:44:25 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Avoid interface mismatch messaging
Thread-Topic: [PATCH] drm/amd/pm: Avoid interface mismatch messaging
Thread-Index: AQHcKSiM2Aaf1af7uUKBvjQ6W54v4rSaBlSAgAAGOoCAAAB7sA==
Date: Fri, 19 Sep 2025 06:44:25 +0000
Message-ID: <PH7PR12MB59977CF6BC44D81AA52974948211A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250919054439.3115476-1-lijo.lazar@amd.com>
 <PH7PR12MB5997B2F4AF83B9FDEAA5D0AA8211A@PH7PR12MB5997.namprd12.prod.outlook.com>
 <DS0PR12MB780437C8C982905466CFD9179711A@DS0PR12MB7804.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB780437C8C982905466CFD9179711A@DS0PR12MB7804.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-19T06:30:10.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DS7PR12MB5792:EE_
x-ms-office365-filtering-correlation-id: 54cb1ef8-dce1-49b5-5899-08ddf747f97a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?uzY8IN/sqyjlEsJ6cmooM5B+kSU/dhAPYDvIhIeL1scbWs/MZQjPO4sxoLMc?=
 =?us-ascii?Q?PfwM6b+OAjyWch1RgCtViS4QSQi6vB7a9Xh+2g5bDV+uF46hmq3KHWnqmZ/x?=
 =?us-ascii?Q?cEkhS+u4bWVPJfYcVbKfOtQlUuPXSMqp8zjWy6ZJm2d0yLseHZ4Xg+mMTt1e?=
 =?us-ascii?Q?5mApaFlgPaN/soHGXI4RDt8n5lQl2nXXtF8c1kdZ9JhLR5aORmok63gU8qHg?=
 =?us-ascii?Q?dAXnjc+SukgaNzUpLrM1pAjz9AiJ+7nzjlG/qnxn1OpYI5AOvljvL2ygZYl/?=
 =?us-ascii?Q?Ar/n5herzxYzyJbs9yyt/Mk91V8jKJnQXyfTuzTOI/GgbktAmjOv4lHYarnH?=
 =?us-ascii?Q?Cfa2eVRtcBSDdzJvgZtXEELxJZAbbrHOQO8x+5Yey7P4xIsggburWohEVNb2?=
 =?us-ascii?Q?jfaRX/0rgxKB5CzDTTW39fNPWvLYTyLOcn9YX2UeXYvNlE2Y+Xmx5ot2ExwW?=
 =?us-ascii?Q?E1nxpiIPtr4CiAenzGXR98Iv4Heq9BvihDqDsRT/+WAF8bHpMV1hOFg8Gudv?=
 =?us-ascii?Q?q4QCfLe0vIeXzaMKg0RttmNL96jTe+SZB5JWUZTxB8ggfWNjl+qL4Qd9y9+i?=
 =?us-ascii?Q?JujkcgjeRUV7aWRgNvW+SnZFNFZGrHglob/9ydiAf96og4LALhmPghuKGCaw?=
 =?us-ascii?Q?spfIqBRBEsB/07i1JInm/JaGydhW2/LRT9d6Ez0DpUoGdMhwiQob31hgjrBV?=
 =?us-ascii?Q?Q39jV8g3VLflBM29gLksC6764Es+urXvIXzAAE5GFxZZPX8cf44tidig8oWi?=
 =?us-ascii?Q?dgx4VrDfqFbLeQQ9SP0YibIm6Lyz0H0X5PNHZ7o66ocwR+/Tx7HAg2EC0POv?=
 =?us-ascii?Q?8zcMMOkFY7HrA+j7vT9ozKvSdUtPfb2BjJESuQWJkhT1FiEErK5/6Je2sK5F?=
 =?us-ascii?Q?aAhF1YPz0ZVcZSP9CegYqhk7D/OgYvDCxRmQXsI4OG+8yHblBASsGV0JKX8p?=
 =?us-ascii?Q?65oXrY4+oPncewVh+vwQbgmqGJ3UsdNxcaUOlSAWluhHfu+8l8z7/aGdoIVF?=
 =?us-ascii?Q?7U2OLIITqCXL2RWNvEJnOc+d6nbfETsRxGSC19q6ik7kVrqhnmvRF80TSISJ?=
 =?us-ascii?Q?K/eGvs3xWgWou+2I3wdyECf6ZK1F7L7UiYGmDu3iLgM9e19u2aB2fPeDMk9x?=
 =?us-ascii?Q?9tdILCw3Y33ZUi5jpp+/DvAoSJtcsaMyTqMW+mMuAkYyWGJUU37e1Ez/mpc+?=
 =?us-ascii?Q?O1fbq9lS/wEsZlSoTdp/me9X6cwXDA0QlHKo1k+dIZbS6gc40V4YOSAQnXX0?=
 =?us-ascii?Q?UwZdxuEe2h/iUT8OGGpwyn98XE+wrDWo74FIZ0RsiMC8e76053eyg6b7Cvvf?=
 =?us-ascii?Q?C0av0YVuPnhWBO9pdcqIChgAYDAhSnaEOdUfnHWt3Fb8a4csPJlk2QJaBcH6?=
 =?us-ascii?Q?MMutUMVSiZbap4k9RyNI0HcP5JaKoD5ndPb1Vs/wd/Bv5B2WTCjBlDzILzNQ?=
 =?us-ascii?Q?SIS6h6REANvRX4F89KBKQSFaQq8unonc97jWHa7Pbi2BDAITlm4EduGxIQBc?=
 =?us-ascii?Q?/uWJxqjMKSfSNtc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bmh/ycLw/fqi0WEuFIl0YIe37ZEkQH2Vph4s8XGj2tSIJAVI7vIMXvm2aG2L?=
 =?us-ascii?Q?jvjsWcWUIfInTc2ebdQgGi6y3VAbL/vwZSTI5OZZJ5AIKrlxoICUgJBHF3cZ?=
 =?us-ascii?Q?mMCWXlabwgp1OXo2vRv9MTGb9yJErTcGBZE8rPHj0a8enZ/nm6J4Jxq9LL6s?=
 =?us-ascii?Q?CdSOLhCSYham0Qs66vl3TPP53ShGw7yXLai+AJ2jm2XKk8wNNRNDEQ4LNiyV?=
 =?us-ascii?Q?ipCeYc0GyrNDhWUDctw/BbE+oMUlUZ7qgDc72BJy1z5xcNFnTurbhREtOBHy?=
 =?us-ascii?Q?bb433kTAhNy5UZVtUukYVm9gyPESgsNSaGLT8fkm/cOVTozS2B4sG5szlWGt?=
 =?us-ascii?Q?M8pWgKJroBQtYZXEZ2BRU6EEgZcy6xuks+w5vDjmdDyRLL1KzIT/QVhoYnX1?=
 =?us-ascii?Q?NohTpfvhnlLlBxTtZ5GN19Vl7KOQNNMFdHoQrRqg709QHWgCNvLGnf2Cb5pU?=
 =?us-ascii?Q?TtTe3hpyNfBK8m2qbt/be9o6pvbI73DBEYLfwsQ0kvYzg/zqCrKqjL1GjZyK?=
 =?us-ascii?Q?DzUpYlTyCq3rpxnlMtYe+q2nkrUfnKctLwdcpUK64cSQ4MWi6ywe1OHfvLGl?=
 =?us-ascii?Q?W4IVBgLkLlgTNmgm7blQ3pmUcdp4mYIHHJU9f9ROyzlBzxo24Bb4bd9aHLMe?=
 =?us-ascii?Q?ZrHDzX08tGmDz6J6qQwUC7cvyGLTyTXaCUPG29vSktyPBm7KRuzCWOxoBix5?=
 =?us-ascii?Q?tw2YlCPRVpaSGvWZ0b+eWwV5oxg8XgI4/IroL7Xqd9HYT7uCkeBMW+9wzdQ6?=
 =?us-ascii?Q?G2i/WYXXUHOxGoKauuOUUwgD/4uJAaErC7QiDr/xxANA8ZBpf4tdhQycLebz?=
 =?us-ascii?Q?wvKTLcTDkhSRtWzu2N/JnsjSD9JDtQQVtmRqXl3z7IpnPQ4aTmlqRznzLIXv?=
 =?us-ascii?Q?xHzoLnBCuHvTdP7edUmtzkXpB5Ho+YcR5dPLZiYeS48KxICLa5or0QKuz6k9?=
 =?us-ascii?Q?vekf1mLoEDJ1F5dPawZVr+yl/UvuD8tUUSPkJubLD6qAKU/9/9HTx20Cnvhr?=
 =?us-ascii?Q?Bdnl5mtYyZ2LjCSzYThpQ4zVK4XMLSpsfbMsAULOQmqqCKj1TUikUpGoAVBT?=
 =?us-ascii?Q?5irTGBEr6ZkyopeaFW7O6OvaVLawd+WSlQbDnHR1BGS3FFnLK5I+/Otf3bNQ?=
 =?us-ascii?Q?jpRyp80TaiBjalmcetyFFgizmGshQzcpjfJ0epWyAQ/B/vpo6BGroNP08hJk?=
 =?us-ascii?Q?iarnjySLSlpQpNqm959M9L59SBEKkZxsGfPeso8KibajuvE3JRVrIj5O84+5?=
 =?us-ascii?Q?nfhvdmA3EyRCpdxXQZvwY9PtxL2KMRtvEgHtbW3yuXlWlUhQWAAjScXtGzz/?=
 =?us-ascii?Q?263O6+45oIMI6LkCw9hRWRZRnBblO6PljNoHZru6dFWyVl/GIRBfQtkBm6QL?=
 =?us-ascii?Q?sHoDGzvVrj+1HOPDE+eETAVqHC+lGA4QX/G7iZ/vNiHnT1DJ3IYtWudP07qw?=
 =?us-ascii?Q?SGGD0rhxW154Xz4Nsnt02+cAatjMwiUAjTzM9WTT87tLtkoAnthdFGSI1wVz?=
 =?us-ascii?Q?uKhYQtqvW/yz8T69gaAeaqJL2jMliCbS4lVuoc00/bdwY+m89oQyXAMhxwby?=
 =?us-ascii?Q?EToWfC1ERUpr7carVUQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cb1ef8-dce1-49b5-5899-08ddf747f97a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 06:44:25.6727 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ezUtsuTSDwaltR9o8NAYc4LsrHMaBmr8dGryvGVpyZDPOxTwuzz41JONMu3P5bA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5792
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

>> " is not used": Actually, this is used to display information to users a=
nd developers, not the driver itself.

This "driver_if_version" is used to show what driver if source file version=
 is using on current driver, this information is used to *developers* and *=
user* from dmesg.log, not driver *itself*.

>> This interface version is not used anywhere. Driver ensures backward com=
patibility by PMFW version checks and shows the exact PMFW version in dmesg=
 log. PMFW version is a more authentic way to identify any compatibility. S=
o having a mismatch statement in the log is only leading to confusion.

Pmfw/driver_if_version is the remote(pmfw) version, while driver_if_version=
 is the local (kmd) version,
Because the driver allows for their existence without matching, more inform=
ation is needed.

They should not be confused as they do not display the same type of informa=
tion.

Best Regards,
Kevin

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, September 19, 2025 2:34 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Avoid interface mismatch messaging

[Public]

> Hiding this information seems unreasonable unless there is another strong=
 reason

This interface version is not used anywhere. Driver ensures backward compat=
ibility by PMFW version checks and shows the exact PMFW version in dmesg lo=
g. PMFW version is a more authentic way to identify any compatibility. So h=
aving a mismatch statement in the log is only leading to confusion.

Thanks,
Lijo
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, September 19, 2025 11:59 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Avoid interface mismatch messaging

[AMD Official Use Only - AMD Internal Distribution Only]

>> PMFW interface version is not used by some IP implementations like SMU v=
13.0.6/12, instead rely on PMFW version checks. Avoid the log if interface =
version is not used.

" is not used": Actually, this is used to display information to users and =
developers, not the driver itself.

Smu 'driver_if_version': it is used to show driver source file interface ve=
rsion on kernel driver side.
Smu 'If_version': it is returned from pmfw side, that means what driver if =
version is using on pmfw side.

The most perfect aesthetic situation is using same if version between drive=
r and pmfw side, but it can still work normally even if it is not matched. =
(with limited functionality)

According to the SMU driver design, KMD will not reject interface version m=
ismatches to ensure smooth driver loading.
Preserving this information helps the driver understand the KMD/PMFW operat=
ing environment and detect problems early.
Hiding this information seems unreasonable unless there is another strong r=
eason.

Best Regards,
Kevin

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, September 19, 2025 1:45 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Avoid interface mismatch messaging

PMFW interface version is not used by some IP implementations like SMU v13.=
0.6/12, instead rely on PMFW version checks. Avoid the log if interface ver=
sion is not used.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h               | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 1a1f2a6b2e52..a89075e25717 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -288,7 +288,8 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
         * Considering above, we just leave user a verbal message instead
         * of halt driver loading.
         */
-       if (if_version !=3D smu->smc_driver_if_version) {
+       if (smu->smc_driver_if_version !=3D SMU_IGNORE_IF_VERSION &&
+           if_version !=3D smu->smc_driver_if_version) {
                dev_info(adev->dev, "smu driver if version =3D 0x%08x, smu =
fw if version =3D 0x%08x, "
                         "smu fw program =3D %d, smu fw version =3D 0x%08x =
(%d.%d.%d)\n",
                         smu->smc_driver_if_version, if_version, diff --git=
 a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/a=
md/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 349b6b8be010..062f92635215 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3930,7 +3930,7 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *sm=
u)
        smu->feature_map =3D (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=
=3D IP_VERSION(13, 0, 12)) ?
                smu_v13_0_12_feature_mask_map : smu_v13_0_6_feature_mask_ma=
p;
        smu->table_map =3D smu_v13_0_6_table_map;
-       smu->smc_driver_if_version =3D SMU13_0_6_DRIVER_IF_VERSION;
+       smu->smc_driver_if_version =3D SMU_IGNORE_IF_VERSION;
        smu->smc_fw_caps |=3D SMU_FW_CAP_RAS_PRI;
        smu_v13_0_set_smu_mailbox_registers(smu);
        smu_v13_0_6_set_temp_funcs(smu); diff --git a/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index d588f74b98de..0ae91c8b6d72 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -40,6 +40,8 @@
 #define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
 #define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9

+#define SMU_IGNORE_IF_VERSION 0xFFFFFFFF
+
 #define smu_cmn_init_soft_gpu_metrics(ptr, frev, crev)                   \
        do {                                                             \
                typecheck(struct gpu_metrics_v##frev##_##crev *, (ptr)); \
--
2.49.0



