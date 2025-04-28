Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FFFC369D3
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 10:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A81A410E3E6;
	Mon, 28 Apr 2025 10:12:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RoQ9Syyf";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AB7E10E3E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 10:12:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mi9de5zKfIrg7MesVbS0V7tVvwXRoeBdooff1yjttFtfwvU59U0wh/gO8l2kdyM/5wM9VF8eDVpbGl9ube5i4ARatukPFFy6vb76vo4uAosR+vQR+QEWPgvMf6HHA2vymBf1NaKmhvzo0dGhf+AaRvcn1fIO5H7XLENIC3+cjCHqN/jNeED61a31rpVkLpp1mosksus9OjTYy69/sywa9WwvPJ7YBeZ0SRr8yNVZcFEZvUPQ+ehS4sWb86zRogZ9AHY8n4oXVKBtM89bGn5W1j3DpGCtfvVrW3Xa/WEE1hCP7wXkEplmbh4SbDSV+uVx6JcM2V99jk4clfMIURj95A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knraYmH4OdL3M3ThksZfsQNhMvC46P6hDJuu7IsAx1k=;
 b=MMLkXxFsgQCHU7aUvqrWiFovsQOGNdVy1T2KAp4RuOoOryXrhuS2oV6TX7WXyADGJPDDViFfRkjkrrCGtCP6Psv1H6se64g8bAhO6Fr6365vuPGQ3AXqTZrlALo7b/wB3ZkUKRjcJO9shQiBdpIcxLjLrdgcgCmQgflG5eO1MpPYDdC0y30mi++iBXCBzvsUkGhvoIRgMW7YjZfFebTxswen26HWwIkYscvfrnRmUbaXNG8PrPx/jB/NbT7w5A7IzcX2ZsJNOsI9/gJYaHAs2KIrWS4BdRZf2Bcn00S3zYrQpkpWVlUV7woewqdLP6gNHwH8xiE20oTY6Uq8vzYLeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knraYmH4OdL3M3ThksZfsQNhMvC46P6hDJuu7IsAx1k=;
 b=RoQ9Syyf/vL68yY+uxZvr2Kory3RCTDu3pByH0cwk+bTsIe5xj4KFT5FRiZqi5iET2V8lc+H5ezxZ0NwsvnxNbSseqBl0fm8hlT2Ki8nxqpo2fguy4BzoNKghMK7rs0kAIL1KiRSZOqRU1uUlBl2nd0dv0LQx0Lc5rXbqT+19T8=
Received: from IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 10:12:49 +0000
Received: from IA1PR12MB8405.namprd12.prod.outlook.com
 ([fe80::2b09:e2:1ee1:5fea]) by IA1PR12MB8405.namprd12.prod.outlook.com
 ([fe80::2b09:e2:1ee1:5fea%7]) with mapi id 15.20.8678.025; Mon, 28 Apr 2025
 10:12:42 +0000
From: "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>
To: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>,
 =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>
Subject: RE: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expired error
Thread-Topic: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expired error
Thread-Index: AQHbrSrP5jEga9/xXECMUfv7z3IS+LOmU9uAgAKqkAWACTvUooAGtyAg
Date: Mon, 28 Apr 2025 10:12:42 +0000
Message-ID: <IA1PR12MB84052CA90E0C3CD73B3087C3A8812@IA1PR12MB8405.namprd12.prod.outlook.com>
References: <20250414104655.336497-1-guoqing.zhang@amd.com>
 <20250414104655.336497-7-guoqing.zhang@amd.com>
 <0ca1a883-4ddd-4bc5-8d58-9865a6d497b5@gmail.com>
 <DM4PR12MB5937E0B16D42C51FFC0D3E45E5BF2@DM4PR12MB5937.namprd12.prod.outlook.com>
 <DM4PR12MB593776A65DBB235A1A9780FBE5852@DM4PR12MB5937.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB593776A65DBB235A1A9780FBE5852@DM4PR12MB5937.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Christian.Koenig@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-18T06:37:37.7964291Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB8405:EE_|SA0PR12MB4381:EE_
x-ms-office365-filtering-correlation-id: a5ec0b72-3703-431e-02a7-08dd863d36cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?S62GP5kDwHROMkisZjuT34uMXe/GHX+XM6kGnH9iO63zFbvJCzPm8M1pkf?=
 =?iso-8859-1?Q?zYK97gfsFp7kUjtCud1FlfSn5KMnMI9pwJyxoIZewsAUYuP5qdysQFALLX?=
 =?iso-8859-1?Q?ASD+tQHuaXkN/xfvzPDfPkLLieVgqK7gsiyUHrV5bchgoZwwhTz61sBx20?=
 =?iso-8859-1?Q?tzl5V1YXvb1ia8snvCT50fNaXij7FTmGgdb5QlpEQybx6IZeiFqEAsJKUE?=
 =?iso-8859-1?Q?KR7vzi4VPdcRhKSI7qoTPHq1bIS1u53m99a+zHPQ1p769Q3g64OopLRjER?=
 =?iso-8859-1?Q?7NZv5FiZdrwN7bbKnQBR3f1Ht8RPzrm6EoShPexp281rtp6qPu1kTqqQRx?=
 =?iso-8859-1?Q?9Z7OieMcyo8LKB+iPbcqpOAwikeJnlDxDC/qFRJQulTILOaRG113Y67va4?=
 =?iso-8859-1?Q?kPhRdKsjcoqC8i2CnMFahPOaGJq3Bnnl7mDXwAGXZ12M38DjCpaUm/D1XX?=
 =?iso-8859-1?Q?0wDtHEPn5H+29BMZ1qGAs1eC1wwFywUPgiU0xjYYpVzmw2seY3V89rI4iu?=
 =?iso-8859-1?Q?VUcRY7YIbrjFkj/GF2X8onxsBhXjz9chOdfCoUhaQS+4AXpVPu04x8/YZY?=
 =?iso-8859-1?Q?orYtSZRYrbhveab92m0MxNo06nweCXLg1C3kfLolUpDlXfhqX8OuHTaK8A?=
 =?iso-8859-1?Q?Hfnf4KrySAkrHq0Ue8OEd/PW9RSdcdYM775CnW8TNT9B/xpdloCXZ2sxY0?=
 =?iso-8859-1?Q?wh5hsKM75kLbGJbWbtU/RDeHsJhdFvXYv5TyZF/h21335JCS5F4Jgkq+HI?=
 =?iso-8859-1?Q?DgYHf78KVx2/NY1poALZ1qjZhMgf7+l5qpgQyA09YEwiVlRgi9wfrIsBrk?=
 =?iso-8859-1?Q?p0dQXEbrz88FvL7EBGUI+/LFezxeVBKLtAJNS0mh7MkxVtj7KiqNLuYV/I?=
 =?iso-8859-1?Q?cbV0IY9geuaBLU3FXBkCAI+RtCSnnB3K3/p03K2FcFNTNI9vLX6pq7qruA?=
 =?iso-8859-1?Q?F+zZIiifbJBh8xRBR5r+0iUhE5afufTqxSHRRKNmYrjNOW2yNALGWC2lt7?=
 =?iso-8859-1?Q?jfeeL2yX+o5XcOfCK/k6rB0fPEyyVQRqmCR+GMnsULL32EEhaL3aGMX+XX?=
 =?iso-8859-1?Q?7v6Zb7jbXGxUGcfyQLkcyyTeH6AlunN3Mo48r/3w4X5MpMfNNaENKsPWmA?=
 =?iso-8859-1?Q?NFEDSJoSTrytHto5PMfy8iXxRQF/q05S3vSO35Ro2aovhLAu9JxtuglB81?=
 =?iso-8859-1?Q?WIa3dD2bxDtiUR15e4+HllSU/RNJ9ukF/5nR40ypx5B+1rgHTLgQK1oLpd?=
 =?iso-8859-1?Q?ABS6kSAy+3hcqV5pEa6aRgE9xemUJM8tspv+dGccquZ9kvb9jtTitHOJGM?=
 =?iso-8859-1?Q?FJpMKFIc0IiuPJaUShN7X4IZI8Cdq072pVvggMXLTVT2wrGbYB+1U5bvL+?=
 =?iso-8859-1?Q?VUYioDYZ892H7oCWXI4KmNKwAs0UWjj/CUq+ZD95IY0Rtsio/nAoghgsIt?=
 =?iso-8859-1?Q?LoXdpHlu5AOHxq17JxFggsUkGq8Agj1UyqUlSg37dk6cLE2h+5JUnv9fiT?=
 =?iso-8859-1?Q?SR8N4E/Hf9sT9CCSUtqjzswk4hXcXIB1C0tKUFm4sXd53PGGQ8zld+MCEa?=
 =?iso-8859-1?Q?oZYoAIo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8405.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UCvVgtOVvrpEBjJd9S8GATqwfId2vpQIuG3LZFi/Qj4b7lefg46jtf8RHb?=
 =?iso-8859-1?Q?BgNyfubi/gAwDWHMfrtWORT1Uu9lEsybe4zf5Td9dZO6aZnPePJgVeh0FA?=
 =?iso-8859-1?Q?qc/DEM4E4A+564S6FRUbK47hgzk2qe0aUIC4cJwCxYokhlnQZXPAifyrjF?=
 =?iso-8859-1?Q?yqF5Gyj75be6aSg8k610YgXu0wpw9WWM2BvzrpLojd3uXc8YbcRJxciMRQ?=
 =?iso-8859-1?Q?07Q88s8hLmH7lyZgNvLlPy9IUfLULki3HQxAadW211Li89QjXPTAA1YMD6?=
 =?iso-8859-1?Q?sTK22E+pb13MdsFkWT9cRf/CSIyifzo8TLmk+255hnliL5cSQJsrds6NM5?=
 =?iso-8859-1?Q?FANBcD//JEXgOpps9Pt5P00uAyyPPBkLInfxzMVHWSstnGes35Okso/CkM?=
 =?iso-8859-1?Q?U5ZU2dySrnt2FKgEmt34jgMMckrnzqDCaNVezPraq8e6SJ8yP4D5hPzGhN?=
 =?iso-8859-1?Q?NcakHp0QRcOJQhA75r072XGHCl8RtVtR7m0Cz4CGg3Izq1rnD5PYiMXOip?=
 =?iso-8859-1?Q?AomtUF6m2DdEKse5pY1n2o92iBgdzuBjHvjHzfo2SagsGZaYM+JWmfw0eG?=
 =?iso-8859-1?Q?/DmwKxRYn9MgdGiqOZI27nv3wdmC9Yk4USYd5424/e/6OPquy+v5PMxDEV?=
 =?iso-8859-1?Q?k06VHKlWGK40zIejbR2IwOLbqRjjDAPXzpuW/x0AS9+XumQms+Itm3/7pE?=
 =?iso-8859-1?Q?ZMsrobLYkPoPIiQY51CZozUT7MZlCFyFJjP2nK3ay65VKtM09mMZhY+Saj?=
 =?iso-8859-1?Q?IpyKG4iIkSQ91AYO72M5ujrljsq4auilJNREU6flrtE2+gaUGkzPV4Xbcq?=
 =?iso-8859-1?Q?2gdMukeuKP8uot9rOxFmAEciRo9adyTAeZMFIuDVuIXP3xhB2paIHluPw5?=
 =?iso-8859-1?Q?D/wt3iM7X8/kvlvHb/FkeDx3YBzB+QPVtywiIg+k33CLjWAxVKrzmBkX+7?=
 =?iso-8859-1?Q?dbbDtQnvltpTiGCGhi+1bOTAfNknNahT6KDSQsWImb2nO8+aesm8I0Qi22?=
 =?iso-8859-1?Q?nwUbPf+qnWv8Fow3lYcmJf6h10tTS6ZtpOzwNxaX6pWCkmS5ONL7fZUb/n?=
 =?iso-8859-1?Q?JSkLe+yi8L1+3RMxs9T164TFZP4kpqoRGyqa47C3mEAYqK9szUfq4hppek?=
 =?iso-8859-1?Q?JiF46OR+k/Sqf8SGxWjblbq0Qu4126dM1VVx8PoqGuzX3sOkYxzpfxH8cJ?=
 =?iso-8859-1?Q?uAba/eLqMB5jkGkrV41GHpdR7RMIqUX1d2BOKnGhgmIPeLqLgYvy5twIvK?=
 =?iso-8859-1?Q?6D99kbX0FOiFe2vWyO43TOAxZl+QTEnzl3a6Pxcq0cvVD+3maAHvsOsIAv?=
 =?iso-8859-1?Q?F7AVXO4D76BLtPuTJqYLPPSDmkLtSB4CbJIOFeGqh8L26rKckIB10+CkRg?=
 =?iso-8859-1?Q?5vOtMZE0qi/i5JwjOb0oJB0jXlW550yZ2aPFPv1C4W7xhjAsXBN0xPMB1Z?=
 =?iso-8859-1?Q?bvber6XoxnFstpRNWFTxjwrF//MCXApVuVm/tmTQhtEpj1ru6wL4XTDY7c?=
 =?iso-8859-1?Q?WDZ5MykOGWZP3KbUSztN7VqVjKFtTHvkcUU6Jlo6VBOLAv3/s7uyEgPA7T?=
 =?iso-8859-1?Q?pPYL5BOnb0qqtXUXQcWHfdxLc7ziaWu2ax3NfjKH2BOG3zmdyqz6el6MgA?=
 =?iso-8859-1?Q?S2ULzJPiBI+k4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_IA1PR12MB84052CA90E0C3CD73B3087C3A8812IA1PR12MB8405namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ec0b72-3703-431e-02a7-08dd863d36cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 10:12:42.6788 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y1BecqG06KM5bqQKy7Q9WBhSQpH/7hypUZL9ZsNxNtnUmO3kJ18DbTa6KnImvau6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
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

--_000_IA1PR12MB84052CA90E0C3CD73B3087C3A8812IA1PR12MB8405namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi, @Koenig, Christian<mailto:Christian.Koenig@amd.com>

Looking for your expertise... Thanks for support.


Rgds/Owen

From: Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com>
Sent: Thursday, April 24, 2025 11:39 AM
To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.fre=
edesktop.org; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexan=
der <Alexander.Deucher@amd.com>
Cc: Zhao, Victor <Victor.Zhao@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com=
>; Deng, Emily <Emily.Deng@amd.com>; Zhang, Owen(SRDC) <Owen.Zhang2@amd.com=
>
Subject: Re: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expired error


[AMD Official Use Only - AMD Internal Distribution Only]

Ping... @Koenig, Christian<mailto:Christian.Koenig@amd.com>

Thanks
Sam

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Zhang, GuoQing (Sam) <GuoQing.Zhang@a=
md.com<mailto:GuoQing.Zhang@amd.com>>
Date: Wednesday, April 23, 2025 at 14:59
To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.leic=
htzumerken@gmail.com>>, amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.=
freedesktop.org> <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freede=
sktop.org>>
Cc: Zhao, Victor <Victor.Zhao@amd.com<mailto:Victor.Zhao@amd.com>>, Chang, =
HaiJun <HaiJun.Chang@amd.com<mailto:HaiJun.Chang@amd.com>>, Deng, Emily <Em=
ily.Deng@amd.com<mailto:Emily.Deng@amd.com>>, Zhang, Owen(SRDC) <Owen.Zhang=
2@amd.com<mailto:Owen.Zhang2@amd.com>>
Subject: Re: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expired error

[AMD Official Use Only - AMD Internal Distribution Only]


[AMD Official Use Only - AMD Internal Distribution Only]

Hi @Christian K=F6nig<mailto:ckoenig.leichtzumerken@gmail.com>,

On QEMU VM environment, when request_irq() is called in guest KMD, QEMU wil=
l enable interrupt for the device on the host.

When hibernate and resume with a new vGPU without calling request_irq() on =
the new vGPU, the interrupt of the new vGPU is not enabled. The IH handler =
in guest KMD will not be called in this case.

This change is to ensure request_irq() is called on resume for the new vGPU=
s.

Regards
Sam

From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.le=
ichtzumerken@gmail.com>>
Date: Wednesday, April 16, 2025 at 21:54
To: Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com<mailto:GuoQing.Zhang@amd.co=
m>>, amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <a=
md-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Zhao, Victor <Victor.Zhao@amd.com<mailto:Victor.Zhao@amd.com>>, Chang, =
HaiJun <HaiJun.Chang@amd.com<mailto:HaiJun.Chang@amd.com>>, Deng, Emily <Em=
ily.Deng@amd.com<mailto:Emily.Deng@amd.com>>
Subject: Re: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expired error
Am 14.04.25 um 12:46 schrieb Samuel Zhang:
> IH is not working after switching a new gpu index for the first time.
> IH handler function need to be re-registered with kernel after switching
> to new gpu index.

Why?

Christian.

>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com<mailto:guoqing.zhang@a=
md.com>>
> Change-Id: Idece1c8fce24032fd08f5a8b6ac23793c51e56dd
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c |  7 +++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 18 ++++++++++++++++--
>  3 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_irq.c
> index 19ce4da285e8..2292245a0c5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -326,7 +326,7 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>        return r;
>  }
>
> -void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
> +void amdgpu_irq_uninstall(struct amdgpu_device *adev)
>  {
>        if (adev->irq.installed) {
>                free_irq(adev->irq.irq, adev_to_drm(adev));
> @@ -334,7 +334,10 @@ void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
>                if (adev->irq.msi_enabled)
>                        pci_free_irq_vectors(adev->pdev);
>        }
> -
> +}
> +void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
> +{
> +     amdgpu_irq_uninstall(adev);
>        amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
>        amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>        amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_irq.h
> index 04c0b4fa17a4..c6e6681b4f71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> @@ -123,6 +123,7 @@ extern const int node_id_to_phys_map[NODEID_MAX];
>  void amdgpu_irq_disable_all(struct amdgpu_device *adev);
>
>  int amdgpu_irq_init(struct amdgpu_device *adev);
> +void amdgpu_irq_uninstall(struct amdgpu_device *adev);
>  void amdgpu_irq_fini_sw(struct amdgpu_device *adev);
>  void amdgpu_irq_fini_hw(struct amdgpu_device *adev);
>  int amdgpu_irq_add_id(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd=
/amdgpu/vega20_ih.c
> index faa0dd75dd6d..ef996505e4dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -643,12 +643,26 @@ static int vega20_ih_hw_fini(struct amdgpu_ip_block=
 *ip_block)
>
>  static int vega20_ih_suspend(struct amdgpu_ip_block *ip_block)
>  {
> -     return vega20_ih_hw_fini(ip_block);
> +     struct amdgpu_device *adev =3D ip_block->adev;
> +     int r =3D 0;
> +
> +     r =3D vega20_ih_hw_fini(ip_block);
> +     amdgpu_irq_uninstall(adev);
> +     return r;
>  }
>
>  static int vega20_ih_resume(struct amdgpu_ip_block *ip_block)
>  {
> -     return vega20_ih_hw_init(ip_block);
> +     struct amdgpu_device *adev =3D ip_block->adev;
> +     int r =3D 0;
> +
> +     r =3D amdgpu_irq_init(adev);
> +     if (r) {
> +             dev_err(adev->dev, "amdgpu_irq_init failed in %s, %d\n", __=
func__, r);
> +             return r;
> +     }
> +     r =3D vega20_ih_hw_init(ip_block);
> +     return r;
>  }
>
>  static bool vega20_ih_is_idle(struct amdgpu_ip_block *ip_block)

--_000_IA1PR12MB84052CA90E0C3CD73B3087C3A8812IA1PR12MB8405namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"Microsoft YaHei";
	panose-1:2 11 5 3 2 2 4 2 2 4;}
@font-face
	{font-family:"Microsoft YaHei";}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:blue;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif;color:blue">Hi, <a id=3D"OWAAM305C8177BFAF4C71A612875CD0AF6FA8" href=3D=
"mailto:Christian.Koenig@amd.com">
<span style=3D"font-family:&quot;Arial&quot;,sans-serif;text-decoration:non=
e">@Koenig, Christian</span></a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif;color:blue"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif;color:blue">Looking for your expertise&#8230; Thanks for support.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif;color:blue"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"color:blue;mso-ligatures:standardcont=
extual"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif;color:blue;mso-ligatures:standardcontextual">Rgds/Owen<o:p></o:p></span=
></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif;color:blue"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhang, GuoQing (Sam) &lt;GuoQing.Zhang@=
amd.com&gt; <br>
<b>Sent:</b> Thursday, April 24, 2025 11:39 AM<br>
<b>To:</b> Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;; amd-=
gfx@lists.freedesktop.org; Koenig, Christian &lt;Christian.Koenig@amd.com&g=
t;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> Zhao, Victor &lt;Victor.Zhao@amd.com&gt;; Chang, HaiJun &lt;HaiJ=
un.Chang@amd.com&gt;; Deng, Emily &lt;Emily.Deng@amd.com&gt;; Zhang, Owen(S=
RDC) &lt;Owen.Zhang2@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expire=
d error<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:blue">[AMD Official Use Only - AMD Internal=
 Distribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">Ping&#8230; <a id=3D"OWAAM40A521FF225FC54D968E2E4F371415F5" href=3D"ma=
ilto:Christian.Koenig@amd.com">
<span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decoration:non=
e">@Koenig, Christian</span></a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">Thanks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">Sam<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">From:
</span></b><span style=3D"font-size:12.0pt;font-family:&quot;Aptos&quot;,sa=
ns-serif;color:black">amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.f=
reedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf of =
Zhang, GuoQing (Sam) &lt;<a href=3D"mailto:GuoQing.Zhang@amd.com">GuoQing.Z=
hang@amd.com</a>&gt;<br>
<b>Date: </b>Wednesday, April 23, 2025 at 14:59<br>
<b>To: </b>Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@g=
mail.com">ckoenig.leichtzumerken@gmail.com</a>&gt;,
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc: </b>Zhao, Victor &lt;<a href=3D"mailto:Victor.Zhao@amd.com">Victor.Z=
hao@amd.com</a>&gt;, Chang, HaiJun &lt;<a href=3D"mailto:HaiJun.Chang@amd.c=
om">HaiJun.Chang@amd.com</a>&gt;, Deng, Emily &lt;<a href=3D"mailto:Emily.D=
eng@amd.com">Emily.Deng@amd.com</a>&gt;, Zhang, Owen(SRDC)
 &lt;<a href=3D"mailto:Owen.Zhang2@amd.com">Owen.Zhang2@amd.com</a>&gt;<br>
<b>Subject: </b>Re: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expire=
d error<o:p></o:p></span></p>
</div>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;color:blue">[AMD =
Official Use Only - AMD Internal Distribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;color:blue">[AMD =
Official Use Only - AMD Internal Distribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">Hi <a id=3D"OWAAM7B04ED50E2293946AC1575664F4D4885" href=3D"mailto:ckoe=
nig.leichtzumerken@gmail.com">
<span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decoration:non=
e">@Christian K=F6nig</span></a>,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">On QEMU VM environment, when request_irq() is called in guest KMD, QEM=
U will enable interrupt for the device on the host.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">When hibernate and resume with a new vGPU without calling request_irq(=
) on the new vGPU, the interrupt of the new vGPU is not enabled. The IH han=
dler in guest KMD will not be called in this case.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">This change is to ensure request_irq() is called on resume for the new=
 vGPUs.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">Regards</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">Sam</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&nbsp;</span><o:p></o:p></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">From:
</span></b><span style=3D"font-size:12.0pt;font-family:&quot;Aptos&quot;,sa=
ns-serif;color:black">Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.leich=
tzumerken@gmail.com">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
<b>Date: </b>Wednesday, April 16, 2025 at 21:54<br>
<b>To: </b>Zhang, GuoQing (Sam) &lt;<a href=3D"mailto:GuoQing.Zhang@amd.com=
">GuoQing.Zhang@amd.com</a>&gt;,
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc: </b>Zhao, Victor &lt;<a href=3D"mailto:Victor.Zhao@amd.com">Victor.Z=
hao@amd.com</a>&gt;, Chang, HaiJun &lt;<a href=3D"mailto:HaiJun.Chang@amd.c=
om">HaiJun.Chang@amd.com</a>&gt;, Deng, Emily &lt;<a href=3D"mailto:Emily.D=
eng@amd.com">Emily.Deng@amd.com</a>&gt;<br>
<b>Subject: </b>Re: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expire=
d error</span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Am 14.04.25 um 12:46 =
schrieb Samuel Zhang:<br>
&gt; IH is not working after switching a new gpu index for the first time.<=
br>
&gt; IH handler function need to be re-registered with kernel after switchi=
ng<br>
&gt; to new gpu index.<br>
<br>
Why?<br>
<br>
Christian.<br>
<br>
&gt;<br>
&gt; Signed-off-by: Samuel Zhang &lt;<a href=3D"mailto:guoqing.zhang@amd.co=
m">guoqing.zhang@amd.com</a>&gt;<br>
&gt; Change-Id: Idece1c8fce24032fd08f5a8b6ac23793c51e56dd<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c |&nbsp; 7 +++++--<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h |&nbsp; 1 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/vega20_ih.c&nbsp; | 18 ++++++++++++++=
++--<br>
&gt;&nbsp; 3 files changed, 22 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_irq.c<br>
&gt; index 19ce4da285e8..2292245a0c5d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
&gt; @@ -326,7 +326,7 @@ int amdgpu_irq_init(struct amdgpu_device *adev)<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; -void amdgpu_irq_fini_hw(struct amdgpu_device *adev)<br>
&gt; +void amdgpu_irq_uninstall(struct amdgpu_device *adev)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;irq.installed) =
{<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; free_irq(adev-&gt;irq.irq, adev_to_drm(adev));<br>
&gt; @@ -334,7 +334,10 @@ void amdgpu_irq_fini_hw(struct amdgpu_device *ade=
v)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (adev-&gt;irq.msi_enabled)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_fre=
e_irq_vectors(adev-&gt;pdev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; +}<br>
&gt; +void amdgpu_irq_fini_hw(struct amdgpu_device *adev)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_uninstall(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_ring_fini(adev, &a=
mp;adev-&gt;irq.ih_soft);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_ring_fini(adev, &a=
mp;adev-&gt;irq.ih);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_ring_fini(adev, &a=
mp;adev-&gt;irq.ih1);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_irq.h<br>
&gt; index 04c0b4fa17a4..c6e6681b4f71 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h<br>
&gt; @@ -123,6 +123,7 @@ extern const int node_id_to_phys_map[NODEID_MAX];<=
br>
&gt;&nbsp; void amdgpu_irq_disable_all(struct amdgpu_device *adev);<br>
&gt;&nbsp; <br>
&gt;&nbsp; int amdgpu_irq_init(struct amdgpu_device *adev);<br>
&gt; +void amdgpu_irq_uninstall(struct amdgpu_device *adev);<br>
&gt;&nbsp; void amdgpu_irq_fini_sw(struct amdgpu_device *adev);<br>
&gt;&nbsp; void amdgpu_irq_fini_hw(struct amdgpu_device *adev);<br>
&gt;&nbsp; int amdgpu_irq_add_id(struct amdgpu_device *adev,<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/=
amd/amdgpu/vega20_ih.c<br>
&gt; index faa0dd75dd6d..ef996505e4dc 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c<br>
&gt; @@ -643,12 +643,26 @@ static int vega20_ih_hw_fini(struct amdgpu_ip_bl=
ock *ip_block)<br>
&gt;&nbsp; <br>
&gt;&nbsp; static int vega20_ih_suspend(struct amdgpu_ip_block *ip_block)<b=
r>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return vega20_ih_hw_fini(ip_block);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D ip_block-&gt;=
adev;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D vega20_ih_hw_fini(ip_block);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_uninstall(adev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; static int vega20_ih_resume(struct amdgpu_ip_block *ip_block)<br=
>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return vega20_ih_hw_init(ip_block);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D ip_block-&gt;=
adev;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_init(adev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_err(adev-&gt;dev, &quot;amdgpu_irq_init failed in %s, %d\n&quot;, _=
_func__, r);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D vega20_ih_hw_init(ip_block);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; static bool vega20_ih_is_idle(struct amdgpu_ip_block *ip_block)<=
o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_IA1PR12MB84052CA90E0C3CD73B3087C3A8812IA1PR12MB8405namp_--
