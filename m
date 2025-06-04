Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B773DC5AD49
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 03:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F9C210E6A4;
	Wed,  4 Jun 2025 03:19:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gslvffMh";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B31F710E6A4
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 03:19:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2MYGqwrVeHkhav4BfWf1sJs+axBOskLKSdxofVkeGWEof9LmsHC2zcEyugmgskR1vA4yWZqXBDzmG0U4X3thTnZ/Sj8CuNTVladXwl9U+5Xgi2+kDV1bO0YLQeiyHScN/i/3S7BDkeJEKhfq1+tBCw6L5AGoOxwZOLa/IKRpTEzKZuDZ/u0EeEn9O28rVdvLjCtWVWEOa5nhhIqXnJO0sRTS6NgQohqPhxXoEiISQzuqRSkOAMsAdeeFXKi3fb9YdZYvy5mGMb0dScon6Gv88Oxz/5IRRaT1VPkk325efaUplByf2VFTLlBkRnCjqOm0IfVllhJlxccHj7wu7GAZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yttV7iioEX634BmzU7+QoATBEWFgQ1/Wfy5mmdOxhqA=;
 b=Kptfw1fTCYdGN+m4xfUm4bCLrmQxfoxW3LNC7jMtZjOTBzjeIn+Lhd5qhzlXG/uS3VXckgJcn529Kk58CsZ0RRIVKcw2+iTaYvv/uGpQ/a4PJuJDKq84ZzTfFVgYvy+cpBNlspGVIrDGlgOeiV3U8MHd21D3pJiK5+2Dky0gjiRME/+T2HtDvpdb/QmrskF1x9Kkc/qEmqIYstk3D/EgspglUXlR7BCMSLe+VasW08+VfN3MbO6W+b6PjMa1VVVHjfDU0cFpNu0Gzt1eV+kFtHiniq3QacFi+i8D1vr39s+VYtpaTFAoKc5ioAwS0P0xxvHbPZDXl7Vh0/wYXJmbQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yttV7iioEX634BmzU7+QoATBEWFgQ1/Wfy5mmdOxhqA=;
 b=gslvffMhje2IHX5Lk1UUR6iUZQs2/cZqwP+0diHQT05A4gK9WEjDIqfg4YBNNaS49LNcLl1gHPlaCWRSN5oIszSOg6ph5HxeEJXxyJH+YEyzPY8ywOwxC+ZDZN+Xewis9sUN8+MpptyIh5OsRvasveabPXBR+j1ig7cI/DnaHZg=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by IA1PR12MB8239.namprd12.prod.outlook.com (2603:10b6:208:3f7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 4 Jun
 2025 03:19:34 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%5]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 03:19:34 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Chen, Horace"
 <Horace.Chen@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Owen(SRDC)" <Owen.Zhang2@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: Move the process suspend and resume out of
 full access
Thread-Topic: [PATCH v2] drm/amdkfd: Move the process suspend and resume out
 of full access
Thread-Index: AQHbzvUTZbMMhfehQE6fQzi1RSDgA7PnkvwwgALWOhCAAIkTAIAGPmuQgAEwR2A=
Date: Wed, 4 Jun 2025 03:19:34 +0000
Message-ID: <PH0PR12MB5417560FF6E02AF0009C6CB78F6CA@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20250527104943.3020168-1-Emily.Deng@amd.com>
 <PH0PR12MB5417B96B410513A018108C208F67A@PH0PR12MB5417.namprd12.prod.outlook.com>
 <PH0PR12MB5417541194A32741CF817B898F61A@PH0PR12MB5417.namprd12.prod.outlook.com>
 <IA1PR12MB8405DF7195A951957697A569A861A@IA1PR12MB8405.namprd12.prod.outlook.com>
 <PH0PR12MB5417C3C96F3FDA51A9F3BF6B8F6DA@PH0PR12MB5417.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5417C3C96F3FDA51A9F3BF6B8F6DA@PH0PR12MB5417.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bc3e1e79-46d5-483c-add9-89294efd6437;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-28T06:19:21Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|IA1PR12MB8239:EE_
x-ms-office365-filtering-correlation-id: b26140ef-ef2b-4c35-2fe9-08dda316a0ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?QHMjy3hgeDy/PWTlHnLc9xrxzSJnUQGUsmcOC9+oSDPg8pB1aRp0F7JSwzPl?=
 =?us-ascii?Q?mxkoiiYce1mVwsv+jIJM6ak2r8RypgeVJhC4yyvQJPpAsuj+3Ycgxktw1Hjw?=
 =?us-ascii?Q?qPirF2C+GTXZ0nUcz78XeK+PVYHjofgsA3BRogyHSogfo0jbfu9xmdqyA4n2?=
 =?us-ascii?Q?nEWcVILH7gwUEOAFfnKVhJ0JEYze7HLsC4vivCknlfd0HL9kemMICvLwS5vz?=
 =?us-ascii?Q?1m6M2SoghaGlzMVJQkElwkrolq5YNJ0dTNE0OxMr/UPd8cwEU56pZ/wqZ8gD?=
 =?us-ascii?Q?FQL1+z1vQq9sqytoGyJ9Ypq64aR1e+UHHslx8VjPqjo8anWqMwSi3S7Sko1b?=
 =?us-ascii?Q?D1xXMyJbZmNkz/ELqvDhENzc70cyn7BO8KBiL5ff4oGN3Q357ZUug7uSkfyv?=
 =?us-ascii?Q?5Q8qtoIFJynGBixOJccoAEmpP91i3A0bbLsvHauKgo9MUomJxTC3pBKUWWjv?=
 =?us-ascii?Q?RVsgt9blQ3SGPqJ4w+VEUv6NWfBsOX24/UvWFEZtmMV5orocfq0EW460B3v5?=
 =?us-ascii?Q?aYEzwmRScyVd3Bkixe7Dzcu31cL3NFus1sw6acnCxpR99GCAvFGtrNLRwTUY?=
 =?us-ascii?Q?VeOYKuPwY0xG06eOFljGUcqupI1XzMaI655T+Yvkmq5+MrXtGnkHhsCpcJTX?=
 =?us-ascii?Q?cItAbVSR2GKZNya1NLR3Shav2fOLmvUkJ8YtVFEBkvV1kXshzisS5qBVVB3V?=
 =?us-ascii?Q?NYQb5TgBFipSnbH7N+GIw1Q5561y27Js1yvnS9p1r+NDbJbC7uYSdstHmiz4?=
 =?us-ascii?Q?bpHERRkt2JSIgxv2jg/Z4qgRthvBvzK08ohOIW/hsoxnvyTe+rcJ0WTZRTPV?=
 =?us-ascii?Q?8evvd1cP3mB8EvgK4MDCxYDP+QhNv6Z+Smnt+hwMXw2EotzADqE4pMB80reG?=
 =?us-ascii?Q?LZWW+foRvYgO2w5THEvBvuu6KS0vMmC/QbpgprsMPTmSEH+6LMFbuyz1vZnO?=
 =?us-ascii?Q?NTgYDtuRYjkGnxqptQHAMy6rHoS33pPAgjaNdpllnHociGsALrv1Wp3jDwCx?=
 =?us-ascii?Q?C8c5p6n4Dn/MLXjGyVTBiro8g1wxMF9pFsDQBPT5zFU4kjotCSKY6dvlR0ta?=
 =?us-ascii?Q?ZOvyeyEFoQS0TYVAYFbFJMeO8gLmvtW2QkioooAmRCc0kMh2X/4z76UDxzKM?=
 =?us-ascii?Q?y6KApnlkZd4W1PuDwz8CsLUUBgHUtfvh659v507CdQCnHpjFEFDBQOlCZizL?=
 =?us-ascii?Q?/R+MwbkNM/Ne8nQ1ea2VZ5XJVzmB98m1GgmxeNW97VUPCqQguRcSgcQOCBk2?=
 =?us-ascii?Q?qvmEpdPOdvFc+PtV5C76qhYRSrPE09RmWUlBsclr5p/lN43azI8Yqw3LTAjO?=
 =?us-ascii?Q?FW8mXBPJOiZ2XyG9B2uY9be+JTz4pc39tqEjSmi8nVRzZ94/618LDgjpFez/?=
 =?us-ascii?Q?b/33EJS/iuZH+MKUr2jUXLw75BOTbTpuE+7A+YxgoXIvCn9wph9t7RQaYycz?=
 =?us-ascii?Q?SqrWLlCOEraa+3nHPlybRCRU21a4U2zCrLWYXfvKVEdNCqQleT4kjR7A4Njx?=
 =?us-ascii?Q?4Fz4/4AKh0omoJE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xTyKaOo38n6q1bi1zPTp1SofrYE4BW6PiNWd4rWZUFHUDQa53BKN+VE4xis4?=
 =?us-ascii?Q?AiJVUH1/wtIWhezSN/AJiRY+d+XP8OzjDPsqrvoNA7bwasWswTj8ufXU6LVl?=
 =?us-ascii?Q?Ie6f6CeBlZ9hDsqIiS9esBXkMCqiM4rEJ8990zbHCsRo6mW8RQG+Yd2vbpUF?=
 =?us-ascii?Q?nL547dtWcw332e1sLVuSwoJ9F9EMc8bF/kbrN7LdWPM6hVuMoMlTYVfPwn5+?=
 =?us-ascii?Q?L2tUtgnnFJN/X4xtjsEvQpwF5MHrO/ULqNKC/LKY7olVn7jb1pVJ7MD0ybAY?=
 =?us-ascii?Q?wQ8YLjcx3G+n79Q1jxDdUC8tuD2geYroLWORz8ddkFPAI06O9zVJ/e0SZRIp?=
 =?us-ascii?Q?oPR36BDql6YyB3dfz+At3YDat8klkqkpq1bfecH/sbcx0aFZMIkf9/zzYHtz?=
 =?us-ascii?Q?RmVeiYGx77LFh0Qt47GdgLcLhmKzfpxLEyRXhVJLmOl0gKV8dBs7FrGbNzLA?=
 =?us-ascii?Q?mAg0Tm9IFYynoaU1s/Ibkm8qqUjjzo3MoZcWlhrqtDBSElzwK6lcxyjZSrPn?=
 =?us-ascii?Q?JGPwz3fN05eMOwfjCRarMwF6dvFj+oLRvWpMY/HcogqpGd/9f3H0E/dE9qIV?=
 =?us-ascii?Q?XmhKd6lUroQeHMogyQ3pkf7N/dzBVq6cbLLFntAZBmorSxS+oesCiSBxrVAH?=
 =?us-ascii?Q?4frCwasiEBqmKxQ1mT67HqDAekgc8qVc4cNB1sTzaVypgv2v19c/c97daWp/?=
 =?us-ascii?Q?8OG4SbiGSvmJr2rOOzcooht85asMIei3cMG7DBFziLLLOiC3I+oXHidVsvxA?=
 =?us-ascii?Q?XJxCsBohTb7RPhpI4IQWp8+ChM+Ojb9ZPyNieDupKytcSGjWILeIZT+hM71p?=
 =?us-ascii?Q?ML88hrxJdKMjYwbFxvKlDq2hl72W7EApEDrRxQoa8hOXOATIdi5GhxjNCc6W?=
 =?us-ascii?Q?eltwIepCE6j8R7V+CYC+p42H9xlstE8rY7F204++xOCiRdCjBPwKv8F/UUYS?=
 =?us-ascii?Q?AeIewAzd14hkLIFeVnWFseWI+nW651bbBi/QyYM9r/GU+zh8TjvS5BWfb5/z?=
 =?us-ascii?Q?kr7csp2PC6FubuZ7ilD3UzJO2OBFKfarRKNHjhcXTXIxiJ0/qYXnayrbrw9p?=
 =?us-ascii?Q?T2ieoE5SLBkd4ClSC2EjvBuUt/xvxnxOWAl1BbL3dNxXpL10hO4YalGUIO2H?=
 =?us-ascii?Q?drNLGXEmhklqXCDAf6igXH4nN4bZxE1+TBpZn/f9IWkBzo41Y7BFykUvESnI?=
 =?us-ascii?Q?LAez0lQ0vz4DVwVxowURXnFFWzNuoWfNuX+ajKlO0V0njzZtHQ6rdRTNXkun?=
 =?us-ascii?Q?pD4I3RCiNgv5OUMbnSPcrDL3irm+Bf77muIL1kLMga5X0+5RXjLnetuX4DqO?=
 =?us-ascii?Q?Kdyml/U0O8QrRRLsjBIiFRAJk9F8xGFRLvq0X6cI2b2zLd/kRrMSognkT47H?=
 =?us-ascii?Q?RA6G/Wo3Rvdz1iipgf6nvCWAIm1pOALCbDRoFDV6hKeumS67EmdXXKyHZJCF?=
 =?us-ascii?Q?YrDUonzL5iKahNEBl/p6DkuabIxQ2oVDcDrT9hq2kOUG+JcA+hYdxwu7k4uz?=
 =?us-ascii?Q?DbFXTEs8RPEg3A9RRYNMUvxyfJSA7d0PSt/X0I31lBhqWdoIwtHDkULb3Czr?=
 =?us-ascii?Q?SZfQwjqS/bIBUZzV5wY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b26140ef-ef2b-4c35-2fe9-08dda316a0ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 03:19:34.1742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TPe6c6O3hmGK5tXT4Y6Z59761uP2vG7UNSuu97CoArKF8lfbGnWYtnqUggp8NO7l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8239
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

[AMD Official Use Only - AMD Internal Distribution Only]

Ping......

Emily Deng
Best Wishes



>-----Original Message-----
>From: Deng, Emily
>Sent: Tuesday, June 3, 2025 5:11 PM
>To: Koenig, Christian <Christian.Koenig@amd.com>; Chen, Horace
><Horace.Chen@amd.com>
>Cc: amd-gfx@lists.freedesktop.org; Zhang, Owen(SRDC)
><Owen.Zhang2@amd.com>
>Subject: RE: [PATCH v2] drm/amdkfd: Move the process suspend and resume ou=
t of
>full access
>
>Hi Christian and Horace,
>     Could you help to review this?
>
>Emily Deng
>Best Wishes
>
>
>
>>-----Original Message-----
>>From: Zhang, Owen(SRDC) <Owen.Zhang2@amd.com>
>>Sent: Friday, May 30, 2025 5:50 PM
>>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>>Subject: RE: [PATCH v2] drm/amdkfd: Move the process suspend and resume
>>out of full access
>>
>>[AMD Official Use Only - AMD Internal Distribution Only]
>>
>>Hi Team, @amd-gfx@lists.freedesktop.org
>>
>>Can you pls review and provide your inputs? Thanks for support!
>>
>>
>>Rgds/Owen
>>
>>-----Original Message-----
>>From: Deng, Emily <Emily.Deng@amd.com>
>>Sent: Friday, May 30, 2025 9:39 AM
>>To: amd-gfx@lists.freedesktop.org
>>Cc: Zhang, Owen(SRDC) <Owen.Zhang2@amd.com>
>>Subject: RE: [PATCH v2] drm/amdkfd: Move the process suspend and resume
>>out of full access
>>
>>[AMD Official Use Only - AMD Internal Distribution Only]
>>
>>Ping......
>>
>>Emily Deng
>>Best Wishes
>>
>>
>>
>>>-----Original Message-----
>>>From: Deng, Emily <Emily.Deng@amd.com>
>>>Sent: Wednesday, May 28, 2025 2:20 PM
>>>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>>>Cc: Zhang, Owen(SRDC) <Owen.Zhang2@amd.com>
>>>Subject: RE: [PATCH v2] drm/amdkfd: Move the process suspend and
>>>resume out of full access
>>>
>>>[AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>>>-----Original Message-----
>>>>From: Emily Deng <Emily.Deng@amd.com>
>>>>Sent: Tuesday, May 27, 2025 6:50 PM
>>>>To: amd-gfx@lists.freedesktop.org
>>>>Cc: Deng, Emily <Emily.Deng@amd.com>
>>>>Subject: [PATCH v2] drm/amdkfd: Move the process suspend and resume
>>>>out of full access
>>>>
>>>>For the suspend and resume process, exclusive access is not required.
>>>>Therefore, it can be moved out of the full access section to reduce
>>>>the duration of exclusive access.
>>>>
>>>>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>>>>---
>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 16 +++++++++
>>>>drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 13 +++++++
>>>>drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++--
>>>> drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 40 +++++++++++++++++-----
>>>> 4 files changed, 70 insertions(+), 11 deletions(-)
>>>>
>>>>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>index 4cec3a873995..ba07e9c6619d 100644
>>>>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>@@ -264,6 +264,22 @@ int amdgpu_amdkfd_resume(struct amdgpu_device
>>>>*adev, bool run_pm)
>>>>       return r;
>>>> }
>>>>
>>>>+void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev, bool
>>>>+run_pm) {
>>>>+      if (adev->kfd.dev)
>>>>+              kgd2kfd_suspend_process(adev->kfd.dev, run_pm); }
>>>>+
>>>>+int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev, bool
>>>>+run_pm) {
>>>>+      int r =3D 0;
>>>>+
>>>>+      if (adev->kfd.dev)
>>>>+              r =3D kgd2kfd_resume_process(adev->kfd.dev, run_pm);
>>>>+
>>>>+      return r;
>>>>+}
>>>>+
>>>> int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
>>>>                           struct amdgpu_reset_context
>>>>*reset_context) { diff --git
>>>>a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>index b6ca41859b53..841ae8b75ab1 100644
>>>>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>@@ -156,6 +156,8 @@ void amdgpu_amdkfd_fini(void);
>>>>
>>>> void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
>>>>int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
>>>>+void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev, bool
>>>>+run_pm); int amdgpu_amdkfd_resume_process(struct amdgpu_device
>>>>+*adev, bool run_pm);
>>>> void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>>>>                       const void *ih_ring_entry); void
>>>> amdgpu_amdkfd_device_probe(struct amdgpu_device *adev); @@ -413,6
>>>>+415,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,  void
>>>>kgd2kfd_device_exit(struct kfd_dev *kfd);  void
>>>>kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);  int
>>>>kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
>>>>+void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool run_pm); int
>>>>+kgd2kfd_resume_process(struct kfd_dev *kfd, bool run_pm);
>>>> int kgd2kfd_pre_reset(struct kfd_dev *kfd,
>>>>                     struct amdgpu_reset_context *reset_context);
>>>>int kgd2kfd_post_reset(struct kfd_dev *kfd); @@ -463,6 +467,15 @@
>>>>static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>>>>       return 0;
>>>> }
>>>>
>>>>+static inline void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool
>>>>+run_pm) { }
>>>>+
>>>>+static inline int kgd2kfd_resume_process(struct kfd_dev *kfd, bool
>>>>+run_pm) {
>>>>+      return 0;
>>>>+}
>>>>+
>>>> static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd,
>>>>                                   struct amdgpu_reset_context
>>>>*reset_context)  { diff -- git
>>>>a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>index 625c416c7d45..6e29f8bd54bb 100644
>>>>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>@@ -5080,7 +5080,7 @@ int amdgpu_device_suspend(struct drm_device
>>>>*dev, bool
>>>>notify_clients)
>>>>       amdgpu_device_ip_suspend_phase1(adev);
>>>>
>>>>       if (!adev->in_s0ix) {
>>>>-              amdgpu_amdkfd_suspend(adev, adev->in_runpm);
>>>>+              amdgpu_amdkfd_suspend(adev,
>>>>+ !amdgpu_sriov_runtime(adev)
>>>>+ ||
>>>>+adev->in_runpm);
>>>>               amdgpu_userq_suspend(adev);
>>>>       }
>>>>
>>>>@@ -5097,6 +5097,9 @@ int amdgpu_device_suspend(struct drm_device
>>>>*dev, bool
>>>>notify_clients)
>>>>       if (amdgpu_sriov_vf(adev))
>>>>               amdgpu_virt_release_full_gpu(adev, false);
>>>>
>>>>+      if (!adev->in_s0ix)
>>>>+              amdgpu_amdkfd_suspend_process(adev, adev->in_runpm);
>>>>+
>>>>       r =3D amdgpu_dpm_notify_rlc_state(adev, false);
>>>>       if (r)
>>>>               return r;
>>>>@@ -5178,7 +5181,7 @@ int amdgpu_device_resume(struct drm_device
>>>>*dev, bool
>>>>notify_clients)
>>>>       }
>>>>
>>>>       if (!adev->in_s0ix) {
>>>>-              r =3D amdgpu_amdkfd_resume(adev, adev->in_runpm);
>>>>+              r =3D amdgpu_amdkfd_resume(adev,
>>>>+ !amdgpu_sriov_runtime(adev) ||
>>>>+adev->in_runpm);
>>>>               if (r)
>>>>                       goto exit;
>>>>
>>>>@@ -5199,6 +5202,11 @@ int amdgpu_device_resume(struct drm_device
>>>>*dev, bool
>>>>notify_clients)
>>>>               amdgpu_virt_release_full_gpu(adev, true);
>>>>       }
>>>>
>>>>+      if (!adev->in_s0ix) {
>>>>+              r =3D amdgpu_amdkfd_resume_process(adev, adev->in_runpm)=
;
>>>>+              if (r)
>>>>+                      goto exit;
>>>>+      }
>>>>       if (r)
>>>>               return r;
>>>>
>>>>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>index bf0854bd5555..22c6ef7c42b6 100644
>>>>--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>@@ -1027,15 +1027,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool
>>>run_pm)
>>>>       if (!kfd->init_complete)
>>>>               return;
>>>>
>>>>-      /* for runtime suspend, skip locking kfd */
>>>>-      if (!run_pm) {
>>>>-              mutex_lock(&kfd_processes_mutex);
>>>>-              /* For first KFD device suspend all the KFD processes */
>>>>-              if (++kfd_locked =3D=3D 1)
>>>>-                      kfd_suspend_all_processes();
>>>>-              mutex_unlock(&kfd_processes_mutex);
>>>>-      }
>>>>-
>>>>+      kgd2kfd_suspend_process(kfd, run_pm);
>>>>       for (i =3D 0; i < kfd->num_nodes; i++) {
>>>>               node =3D kfd->nodes[i];
>>>>               node->dqm->ops.stop(node->dqm); @@ -1055,6 +1047,36 @@
>>>>int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>>>>                       return ret;
>>>>       }
>>>>
>>>>+      ret =3D kgd2kfd_resume_process(kfd, run_pm);
>>>>+
>>>>+      return ret;
>>>>+}
>>>>+
>>>>+void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool run_pm) {
>>>>+      struct kfd_node *node;
>>>>+      int i;
>>>>+
>>>>+      if (!kfd->init_complete)
>>>>+              return;
>>>>+
>>>>+      /* for runtime suspend, skip locking kfd */
>>>>+      if (!run_pm) {
>>>>+              mutex_lock(&kfd_processes_mutex);
>>>>+              /* For first KFD device suspend all the KFD processes */
>>>>+              if (++kfd_locked =3D=3D 1)
>>>>+                      kfd_suspend_all_processes();
>>>>+              mutex_unlock(&kfd_processes_mutex);
>>>>+      }
>>>>+}
>>>>+
>>>>+int kgd2kfd_resume_process(struct kfd_dev *kfd, bool run_pm) {
>>>>+      int ret, i;
>>>>+
>>>>+      if (!kfd->init_complete)
>>>>+              return 0;
>>>>+
>>>>       /* for runtime resume, skip unlocking kfd */
>>>>       if (!run_pm) {
>>>>               mutex_lock(&kfd_processes_mutex);
>>>>--
>>>>2.34.1
>>>
>>
>>

