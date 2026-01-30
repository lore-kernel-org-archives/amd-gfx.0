Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B86D49C6F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 08:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBDD210E912;
	Fri, 30 Jan 2026 08:07:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JprviWLa";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010053.outbound.protection.outlook.com
 [52.101.193.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E62AF10E912
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 08:07:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZuFs8zBReiQv0Jg1XD8Z/RFxHdmZpCs4wM92AV5aQMIxU/4IDxgbkYcaFqHyA3L8OwQ2F9puUaY60ZEsIaUAq4a3I0XIpBMuyom/VQLVSyyNfzdt6h8d1uaV2ANsFXsqCnqADbkgJNF0Wn3wm0tdsLiACq76oonYI7M5cfS1Gg5srIUAZrRYsrI2Kg7s+BBLDtKhEixNg5Nww0UFsrcI/YmnYmz30aE747WmLqzi1ahe9Nnuv7KPYKNs6/W3qd6DNKXcvXMWMmt7g7Iw8hxpH7+rw/HRlINw+xpl5tZtJsJj14P4nhVmy/A+RAdE20cRUEOh3zJMCPHI/xNlSQNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJP/7KgkocgLgzVG123BQCdt3PviMc3Yydm6yb0OUMc=;
 b=lU8wFXEltHTPP5xji5ckr7q2pu77C3bjjB/GCzKh+VAb6+taYDhAA0Na/A7skr5LHUjExKBksb/KoKpRfzg9RcrjlZg/4p/aZH6o9kdI5yhVqpuLW7Pgdrm2SIHi0QERQ7VzynaaCcg+gzVCa3RCibx0a7g274peFkO7+owzkl/kQyqooJhocijhYRRxStk7rRKLR80tqszThnLOHFaw26k/yBBXWO56vXzTHDJ3olv5cYdbomR7i/R/3s+D0X2SkXWvLmrymhvNGCWpPbfXSllLj5P4mCVGy+yM3xsY+lM1RxJL6i+SgShrsGYhbKeQgVPu4/dBMCqgryVCFmmH+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJP/7KgkocgLgzVG123BQCdt3PviMc3Yydm6yb0OUMc=;
 b=JprviWLa/JB5mC+n1j/ni/cszANFo1sJhVzWUG1pQqM/PgX7bWKHxMJ+hX494k1Gf2G4rMUF2nA9SS1NGAdF+2iBhtarwQkDuwmxuBpgZp1F+4UpE13GOr063COZswPeCSGgs6PfpNvl2IZCKLq0ySa4m4aR5m5k8D2ZyPUczxY=
Received: from MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 by PH7PR12MB9103.namprd12.prod.outlook.com (2603:10b6:510:2f5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Fri, 30 Jan
 2026 08:07:35 +0000
Received: from MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::f0a2:a7d9:42a8:ace6]) by MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::f0a2:a7d9:42a8:ace6%5]) with mapi id 15.20.9564.007; Fri, 30 Jan 2026
 08:07:35 +0000
From: "Xie, Patrick" <Gangliang.Xie@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH 03/14] drm/amd/ras: add pmfw eeprom smu interfaces
Thread-Topic: [PATCH 03/14] drm/amd/ras: add pmfw eeprom smu interfaces
Thread-Index: AQHckZBwcSTKXLHFWkGZXOMXK8ijurVqMysAgAAojiA=
Date: Fri, 30 Jan 2026 08:07:35 +0000
Message-ID: <MW5PR12MB56843916E46D0B8BE9BD63C3E59FA@MW5PR12MB5684.namprd12.prod.outlook.com>
References: <20260130022950.1160058-1-ganglxie@amd.com>
 <20260130022950.1160058-3-ganglxie@amd.com>
 <dce52ed8-25fc-46a4-8395-435c6f544359@amd.com>
In-Reply-To: <dce52ed8-25fc-46a4-8395-435c6f544359@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-30T08:07:07.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5684:EE_|PH7PR12MB9103:EE_
x-ms-office365-filtering-correlation-id: ffb60377-19ce-47b6-cbc2-08de5fd6a0b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?YmMrZUFaMG90aUhWWEh2dFZKdmlSazVjRE1YNEFxYlhkOGFrR3p2L0xwMVJZ?=
 =?utf-8?B?UHcvdllDa3M2WnlZcXlDZEdkMm1UV0YzN3c2ZlJBT3Y2NFg5ZjY1WWF1bmMx?=
 =?utf-8?B?bEo0cjkxNXlOUHF2SzNoK1ltSXhyZGhHMmhYVzFtSTQrQ09sNHEzZkZDU2VQ?=
 =?utf-8?B?amRZaVowdmNxQ056VUJkUmxqREVZMUJwMDZzL2p4VStZUGlENkEvYkYwUGpt?=
 =?utf-8?B?N3RIa1ZuY29uNE1XNEwxdVFGWVhINk1FVCtwNmhHYzdldlRBNmpWckxSWGtF?=
 =?utf-8?B?TmZLODY5N0ZSSERmZ2Z3M25aQWF1eElKdDFieFdjT3RWMjFSd2RBZVA3V0Mr?=
 =?utf-8?B?OTFKNkRRRE84OC9vRmk2RTRUTERPQ09PYldsazlGWGNVa3VrRGViUmZZUWN1?=
 =?utf-8?B?NGJCdFQ3K2M5dzNZUzF6b3RaczBIV3pPOXo5aTZtWVdsaGRGcllFbWJscTc0?=
 =?utf-8?B?dTZOdHVPalhEL0VGaDlMUEZrWmVVaDRIWXJOQ1JNUGphV0J1TjgvZUlxTFdI?=
 =?utf-8?B?QkhRbTFvZ25LTEt4TjVWaGQ3eFgySVlOODJhWmtTWlFoOXFpWk9lZDBGQUI1?=
 =?utf-8?B?RmpPc3ByUm5IV0NFK2JrM0ZKMHdjeGxXY1U1RlExbHFpOXZTa09ZcXd0dElT?=
 =?utf-8?B?a2RQdmV0VWpwNzdPQitIM1lkbC9yZDhxWmxYb1R2MW5VRklJTkZmK1huZ0Ra?=
 =?utf-8?B?eTBYNHZVTEVrYVR5Wk5jRXA4NUNLdStKOXcrQjgxQWVHanNrVFY5NlQ1QXJX?=
 =?utf-8?B?S2FvSWovVWFmSGN6a1ZTaHloL05Tb0wzb2NrSk5sWThLak9EOEFycDBWK3BY?=
 =?utf-8?B?VlRoZm1DV2N0dGx1KzJValI5UkNOZmhFRElFc2g4Zi82bi9MQlIvSFZtRlYz?=
 =?utf-8?B?WWNkVXpaWldmSzBkYkRWMm01UVZIQ1N4QnlQZ2FaaEJjb2FnYmNiZy9LcXNy?=
 =?utf-8?B?WUkxKzMrbnNHWWxjL3JRaFFNd3Z3VnFqaVNoRnZ4UmlDSnA4L1NjcnZHdjBq?=
 =?utf-8?B?b0R4c2ZVakJHM3NXcDdkSm13N095VGVMZmcybHI4U0w2Qm5WK0JTTWFkZ3JU?=
 =?utf-8?B?OEd5MC85YUd1b0VuYnlWOHEzN2JUa1pLQ3Yrb09HWWpVbGZWRjdtM2JZa3U3?=
 =?utf-8?B?MFltakpwNFh5a0xuYzRIaGV4ZXduUVZLWitjK3lTbk8wbDhXVDc3Nm9TZW9o?=
 =?utf-8?B?a3FKZFRDY1g2ZEx0OEhjWVAzMGx5MFk1SDkvTlF1UEdvcDJuYUJGTjRBVFJn?=
 =?utf-8?B?NmIycFRpM3Y5WEVyZG9GSERQZWVoRW43Z0dCWkRnM1ZhNmJRbVNuWU1IYzlI?=
 =?utf-8?B?d0U3SXBvVWNTK2NrQkc1NFk1cUFLNnQ0MDYwV0tPbVNLSFUwdTAzQ1FEQVRK?=
 =?utf-8?B?cHU0c0NjLzBnVXRMak5QZkd0Sk5SYVZHanF0cEdHM3RnQ3N1MCtrQ0dYTXBU?=
 =?utf-8?B?RXBCaWlJOXlYSzlqamZGSkN2Ti9oK2dlUGpsSUlhOGEzNVhvdHk5bDZFUzln?=
 =?utf-8?B?VDA0YzlGUytPSVB1Q2Q2NTJxdzdDaDJYYlkxdmlzYkNHWnU4dHhDcnVQR2xU?=
 =?utf-8?B?dWxCQ1ZCa0RkWFBVR1lWOWNTUWFPakhWd296YVA3SVdSbHpMSVZJOXI2YkZv?=
 =?utf-8?B?YVZRZjgzdUUxTWlxOGd1SmtBQ1VDUDZvVmZ4SWtIWmxQRngrY2dTdHkwYlpZ?=
 =?utf-8?B?d0pzRjlocGE1djIwdDlwc3BVZzVVL0hlSGpoT0xCbnBZZjhuR2U5WGxkbGhn?=
 =?utf-8?B?V2lMQmdyWUQ5TUwrWVhBSlF0dUcxc1JsTTNoM2ZidEhHMjRDYWY3bGc1cFAr?=
 =?utf-8?B?YXp3dDV3ZE9Ia0FBd3poSG5xYnJoa2pQM0Q3TXdqU1FuVDhTNWtWRmcxTmc0?=
 =?utf-8?B?bU1WWUh4c2xBTlJma2M2N2VkV3FHM05uOE9ZVm5qcG1BUW1OTFlTZjg1MFhN?=
 =?utf-8?B?U29FYkYyTEhTcGROKzYrSHR1RERaWGNLdjRhYTZ5R1hPYkIxem1POFdvc1dK?=
 =?utf-8?B?Z0ZLN3pmZUhVS25mMmRCRWRSYzVrbnJYNXc2NCtFb3NieVoxSkN6TU56Ky9h?=
 =?utf-8?B?aVBwSWdzSTR5ZURLdlVPYTQ3YjRFT3htQTlaQm1BNkxjTGd1MHREOFF5RFAy?=
 =?utf-8?B?VEV0WEtEUk9qQnF5YzdtNGtRSlRYZGorN0J1NTA0dXZuRnFES2lIaGdWWTFR?=
 =?utf-8?Q?3il7SjU0NB7MJSpP5dFE08Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1VNNk1FWGllTWZhallhUHRjdFo4M0hkM2lNbmpWaHNHZlpSTnRjMWdLS29j?=
 =?utf-8?B?UVpORUxKbXVlRlZxYmFTbFRwSmVvUEFiOHBPS3lqMXh0bklMQU43emhsWUEr?=
 =?utf-8?B?a0ZKZ2piZXIwZXJoYzZROWYvZnk1QTJnQ2hIcm1QQm95M1RGaGRtQzlJUkRJ?=
 =?utf-8?B?SG9rcURxOFVGSU92VmdmVE1rVmx3cG9rck5PakFWVDBXWHppU0pTc1N1SklU?=
 =?utf-8?B?Nkphd01UTERlWHhhTDBreStyQlc0VjJIVXdUQzlLaE1yVm9BNzJ5M0lPeGVu?=
 =?utf-8?B?RlZydm4yL1hoSFNvU21LdlJ6c0ZydURnZEgvdEV6eWE0WmxFQ1R5aFFWZXNN?=
 =?utf-8?B?eU04R2tDaGsyNXBrRExYWVQvMGdWK1YxazMvYUZRNndOY1RZb2V3eGN1aWxY?=
 =?utf-8?B?Nk1LYVFvWG9DeVhtcW1JNHdYZGZ4WjJ6OCtLMW41RjFTTWMxNFdhNFVkU0Vj?=
 =?utf-8?B?c1dkUjNxeDNHRmN6NDh5VTZGMVdncE9oTm1yTmJJQWtZWUg3TmJ5cm1WdTVW?=
 =?utf-8?B?bis5QTJ3cHlGMTlYSytVcWZaaHBRTEN3Q2FQaHJVYy9lNytsbUM3aFRyL2gr?=
 =?utf-8?B?cUtlOEdBbkc3SzZWcTJpVnBTa3FSeUY3Q012eE9HMk9raitJTTJJbEo0NlhJ?=
 =?utf-8?B?SzZqZGFpbmNMUHNjVUZucERLQ1ZkL29HVlBXUldQOGxQYVN4UmRYb1IySytz?=
 =?utf-8?B?UHlIS2kxZU5XMi9WQ2xmNlIxNkhVbkZLT0VkVTBEOTRVUTZBandnTTJFVURW?=
 =?utf-8?B?NjdZVURab1VjZS9nMzVpY0lUMXgrNzMwR1dNblpnYUFVSDJXcTFONXZ3L2ZT?=
 =?utf-8?B?M1ljOHp2b2FqUmZjY0NMbm9GQzd5K2gxWnBZR09ncE83UFR2em9aUzd3WHVh?=
 =?utf-8?B?RG03UnQzb0kwWHkzSEsvZG42MndqN3ZqK0VGRlA3b0g5bHNwdmV6SnMxcXNP?=
 =?utf-8?B?T0xuU0R2U2Mvci8xRHVmRUs1WUhhL2MvZ1NMOTZERWVpckNYYllPb0NZcER2?=
 =?utf-8?B?SC94bEtoNmN4QytJRHJHQ0ZsbWpFL25LaDh5U2I1KzIzTGNuaGRBZWZIU1lw?=
 =?utf-8?B?T05sTnNtb0VVK0FzUUljbFE0YTNLY3d3OEFqNUdQNHJWQXFQTzNMOGdyYWZS?=
 =?utf-8?B?TmUrZDNoTHZXMC8wZmJDenlocWhBMmlDQjFFY0orL21WYzQwYmlLUnNCR1p1?=
 =?utf-8?B?M2pyVkFNcTNXUUZnUWxtbkNxclJRNnRqaW1Idml1Ukd3bUxJamNON1pYQkFQ?=
 =?utf-8?B?ZHRuT1Voai9ZbHVjaFBUMXhBdy9ScXROUmw1b2Y4cUhnMWdaOEJianlHOUNR?=
 =?utf-8?B?cTZvYXFRamVaWFo2T0ZQUS84K0NtL05ZemlxU0phcnVyYys2eDVUME83SW9D?=
 =?utf-8?B?QXE2VXRsOEsweGdBNUpJRyswTFBPVEhxVTZnU3ZHS1dIVytVWHN2SitqbWlU?=
 =?utf-8?B?NllsNGdZTHBnZGlSc2JHeDA2eWlZbEI0bmNjaVVtVE9RSFlhOGdld200Qjlw?=
 =?utf-8?B?NnZ2ZUkrUVRSS1lrYW1PaGRDR2Q4dWEvWFFiNmt6cjNKYVY0RzRyUXpGNVBY?=
 =?utf-8?B?anJ3Qzg3eE4zb2lGeG5iQmRnTHFXWVVmbE1nYlVTUTJheUZOV0hTam1VSDNB?=
 =?utf-8?B?ZjVON1haa1hyekNMMzRUcVhyQ1JBdisvaEdYMXpMSnlJemZacTdBbG5XdFE5?=
 =?utf-8?B?S1EwRjhWZUNsNXZIVzF5M1o2eGpSR3ZyQUo3UUlvTVNncUJhLzNSdE5zcFpr?=
 =?utf-8?B?UmZjMHRPUXpEaCtQYmUvMGhjRWtxMWwyZ0JadFEva085d3NDazVUVWk5MitY?=
 =?utf-8?B?N3dCWUw4TXk5cnFSbjQ0dU5oM0VUQmZWR1BWcEErcjZ4OW1JQ1pWWEhEUi9i?=
 =?utf-8?B?Ni9oVmlFcVJWWWM2VFpNRkhmVWtWVUt2Z21EOXMwVytNUVlscTN0Ni9PZWJK?=
 =?utf-8?B?aEY1Y3hCRzhpR2F4V2VrUjF0dDdueHpUK2s4aTJDR250TThKcHNrVUh3eWls?=
 =?utf-8?B?K0tkYjUxVWowT25zalJCdWVuMWJzdXRnZ09KdkJiTVBDT1RCRXM0bU50UE1z?=
 =?utf-8?B?cm96dXdtSmFjZ0Q5YnYrczVsRG1qZlVNN1NQTHJxL1JMSnpaSXV2Q2xjOGcw?=
 =?utf-8?B?bWFJSjNZVFduMk93SWlyRVJxODFPYmxkMkJWNGE1di9ycDQybHNkb0h4U1kw?=
 =?utf-8?B?YnBoaHR0N0hMZU9OZDh6Ymx2WUVCbTlsN3lqYkRuR0JVUDgvV1JGbXJOeXpC?=
 =?utf-8?B?dGE0SG5Fc09NRVlyT1RqaHNtT3VUY3V3MUtjK0Z2VXhZeE9taklxNjJ3cmFh?=
 =?utf-8?Q?45Eci/pZtJEo5Y3QZx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb60377-19ce-47b6-cbc2-08de5fd6a0b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 08:07:35.6969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zvvSSu9D0eOzbkXMyRCfhIITAxmwk8Q3V7lzJ13K68yCFQhpRXCJ8oCMIwL7xVkREOec2v6q+1jrqVacPGZtmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9103
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KVGhhbmtzLCB3aWxsIHRha2UgdGhpcyBhZHZpY2UNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQpTZW50OiBGcmlk
YXksIEphbnVhcnkgMzAsIDIwMjYgMTo0MiBQTQ0KVG86IFhpZSwgUGF0cmljayA8R2FuZ2xpYW5n
LlhpZUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBaaG91MSwg
VGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47IENoYWksIFRob21hcyA8WWlQZW5nLkNoYWlAYW1kLmNv
bT47IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQuY29tPg0KU3ViamVjdDog
UmU6IFtQQVRDSCAwMy8xNF0gZHJtL2FtZC9yYXM6IGFkZCBwbWZ3IGVlcHJvbSBzbXUgaW50ZXJm
YWNlcw0KDQoNCg0KT24gMzAtSmFuLTI2IDc6NTkgQU0sIEdhbmdsaWFuZyBYaWUgd3JvdGU6DQo+
IGFkZCBzbXUgaW50ZXJmYWNlcyBhbmQgaXRzIGRhdGEgc3RydWN0dXJlcyBmb3IgcG1mdyBlZXBy
b20gaW4gdW5pcmFzDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEdhbmdsaWFuZyBYaWUgPGdhbmdseGll
QGFtZC5jb20+DQo+IC0tLQ0KPiAgIC4uLi9hbWQvcmFzL3Jhc19tZ3IvYW1kZ3B1X3Jhc19tcDFf
djEzXzAuYyAgICB8IDQ2ICsrKysrKysrKysrKysrKysrKysNCj4gICBkcml2ZXJzL2dwdS9kcm0v
YW1kL3Jhcy9yYXNjb3JlL3Jhcy5oICAgICAgICAgfCAxOCArKysrKysrKw0KPiAgIDIgZmlsZXMg
Y2hhbmdlZCwgNjQgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9yYXMvcmFzX21nci9hbWRncHVfcmFzX21wMV92MTNfMC5jDQo+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9yYXMvcmFzX21nci9hbWRncHVfcmFzX21wMV92MTNfMC5jDQo+IGluZGV4IDc5
YTUxYjE2MDNhYy4uMDM5MjJhYTAzNDE3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3Jhcy9yYXNfbWdyL2FtZGdwdV9yYXNfbXAxX3YxM18wLmMNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9yYXMvcmFzX21nci9hbWRncHVfcmFzX21wMV92MTNfMC5jDQo+IEBAIC0yOCw2
ICsyOCwxNiBAQA0KPiAgICNkZWZpbmUgUkFTX01QMV9NU0dfUXVlcnlWYWxpZE1jYUNlQ291bnQg
IDB4M0ENCj4gICAjZGVmaW5lIFJBU19NUDFfTVNHX01jYUJhbmtDZUR1bXBEVyAgICAgICAweDNC
DQo+DQo+ICtzdGF0aWMgZW51bSBzbXVfbWVzc2FnZV90eXBlIHBtZndfZWVwcm9tX21zZ3NbXSA9
IHsNCj4gKyAgICAgU01VX01TR19HZXRSQVNUYWJsZVZlcnNpb24sDQo+ICsgICAgIFNNVV9NU0df
R2V0QmFkUGFnZUNvdW50LA0KPiArICAgICBTTVVfTVNHX1NldFRpbWVzdGFtcCwNCj4gKyAgICAg
U01VX01TR19HZXRUaW1lc3RhbXAsDQo+ICsgICAgIFNNVV9NU0dfR2V0QmFkUGFnZUlwaWQsDQo+
ICsgICAgIFNNVV9NU0dfRXJhc2VSYXNUYWJsZSwNCj4gKyAgICAgU01VX01TR19HZXRCYWRQYWdl
TWNhQWRkciwNCj4gK307DQo+ICsNCg0KWW91IG1heSBjb25zaWRlciBkZXNpZ25hdGVkIGluZGV4
IGluaXRpYWxpemF0aW9uIHRvIGJlIGV4cGxpY2l0Lg0KDQpbUkFTX1NNVV9HZXRSQVNUYWJsZVZl
cnNpb25dID0gU01VX01TR19HZXRSQVNUYWJsZVZlcnNpb24NCg0KVGhhbmtzLA0KTGlqbw0KDQo+
ICAgc3RhdGljIGludCBtcDFfdjEzXzBfZ2V0X3ZhbGlkX2JhbmtfY291bnQoc3RydWN0IHJhc19j
b3JlX2NvbnRleHQgKnJhc19jb3JlLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdTMyIG1zZywgdTMyICpjb3VudCkNCj4gICB7DQo+IEBAIC04Nyw4ICs5Nyw0NCBA
QCBzdGF0aWMgaW50IG1wMV92MTNfMF9kdW1wX3ZhbGlkX2Jhbmsoc3RydWN0IHJhc19jb3JlX2Nv
bnRleHQgKnJhc19jb3JlLA0KPiAgICAgICByZXR1cm4gcmV0Ow0KPiAgIH0NCj4NCj4gK3N0YXRp
YyBpbnQgbXAxX3YxM18wX2VlcHJvbV9zZW5kX21zZyhzdHJ1Y3QgcmFzX2NvcmVfY29udGV4dCAq
cmFzX2NvcmUsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVudW0gcmFzX2Z3X2Vl
cHJvbV9jbWQgaW5kZXgsIHVpbnQzMl90IHBhcmFtLCB1aW50MzJfdCAqcmVhZF9hcmcpDQo+ICt7
DQo+ICsgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2
aWNlICopcmFzX2NvcmUtPmRldjsNCj4gKyAgICAgaW50IHJldCA9IDA7DQo+ICsNCj4gKyAgICAg
aWYgKGRvd25fcmVhZF90cnlsb2NrKCZhZGV2LT5yZXNldF9kb21haW4tPnNlbSkpIHsNCj4gKyAg
ICAgICAgICAgICByZXQgPSBhbWRncHVfc211X3Jhc19zZW5kX21zZyhhZGV2LA0KPiArICAgICAg
ICAgICAgICAgICAgICAgcG1md19lZXByb21fbXNnc1tpbmRleF0sIHBhcmFtLCByZWFkX2FyZyk7
DQo+ICsgICAgICAgICAgICAgdXBfcmVhZCgmYWRldi0+cmVzZXRfZG9tYWluLT5zZW0pOw0KPiAr
ICAgICB9IGVsc2Ugew0KPiArICAgICAgICAgICAgIHJldCA9IC1SQVNfQ09SRV9HUFVfSU5fTU9E
RTFfUkVTRVQ7DQo+ICsgICAgIH0NCj4gKw0KPiArICAgICByZXR1cm4gcmV0Ow0KPiArfQ0KPiAr
DQo+ICtzdGF0aWMgaW50IG1wMV92MTNfMF9nZXRfcmFzX2VuYWJsZWRfbWFzayhzdHJ1Y3QgcmFz
X2NvcmVfY29udGV4dCAqcmFzX2NvcmUsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1aW50NjRfdCAqZW5hYmxlZF9tYXNrKQ0KPiArew0KPiArICAgICBzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKXJhc19jb3Jl
LT5kZXY7DQo+ICsgICAgIGludCByZXQgPSAwOw0KPiArDQo+ICsgICAgIGlmIChkb3duX3JlYWRf
dHJ5bG9jaygmYWRldi0+cmVzZXRfZG9tYWluLT5zZW0pKSB7DQo+ICsgICAgICAgICAgICAgaWYg
KGFtZGdwdV9zbXVfcmFzX2ZlYXR1cmVfaXNfZW5hYmxlZChhZGV2LCBTTVVfRkVBVFVSRV9IUk9N
X0VOX0JJVCkpDQo+ICsgICAgICAgICAgICAgICAgICAgICAqZW5hYmxlZF9tYXNrIHw9IFJBU19D
T1JFX0ZXX0ZFQVRVUkVfQklUX19SQVNfRUVQUk9NOw0KPiArICAgICAgICAgICAgIHVwX3JlYWQo
JmFkZXYtPnJlc2V0X2RvbWFpbi0+c2VtKTsNCj4gKyAgICAgfSBlbHNlIHsNCj4gKyAgICAgICAg
ICAgICByZXQgPSAtUkFTX0NPUkVfR1BVX0lOX01PREUxX1JFU0VUOw0KPiArICAgICB9DQo+ICsN
Cj4gKyAgICAgcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiAgIGNvbnN0IHN0cnVjdCByYXNfbXAx
X3N5c19mdW5jIGFtZGdwdV9yYXNfbXAxX3N5c19mdW5jX3YxM18wID0gew0KPiAgICAgICAubXAx
X2dldF92YWxpZF9iYW5rX2NvdW50ID0gbXAxX3YxM18wX2dldF92YWxpZF9iYW5rX2NvdW50LA0K
PiAgICAgICAubXAxX2R1bXBfdmFsaWRfYmFuayA9IG1wMV92MTNfMF9kdW1wX3ZhbGlkX2Jhbmss
DQo+ICsgICAgIC5tcDFfc2VuZF9lZXByb21fbXNnID0gbXAxX3YxM18wX2VlcHJvbV9zZW5kX21z
ZywNCj4gKyAgICAgLm1wMV9nZXRfcmFzX2VuYWJsZWRfbWFzayA9IG1wMV92MTNfMF9nZXRfcmFz
X2VuYWJsZWRfbWFzaywNCj4gICB9Ow0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9yYXMvcmFzY29yZS9yYXMuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcmFzL3Jhc2Nv
cmUvcmFzLmgNCj4gaW5kZXggMzM5NmIyZTA5NDlkLi4yZGI4MzhjNDQ0ZjEgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcmFzL3Jhc2NvcmUvcmFzLmgNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9yYXMvcmFzY29yZS9yYXMuaA0KPiBAQCAtNDksNiArNDksMTAgQEANCj4g
ICAjZGVmaW5lIEdQVV9SRVNFVF9DQVVTRV9GQVRBTCAgIChSQVNfQ09SRV9SRVNFVF9HUFUgfCAw
eDAwMDIpDQo+ICAgI2RlZmluZSBHUFVfUkVTRVRfQ0FVU0VfUk1BICAgICAoUkFTX0NPUkVfUkVT
RVRfR1BVIHwgMHgwMDA0KQ0KPg0KPiArZW51bSByYXNfY29yZV9md19mZWF0dXJlX2ZsYWdzIHsN
Cj4gKyAgICAgUkFTX0NPUkVfRldfRkVBVFVSRV9CSVRfX1JBU19FRVBST00gPSBCSVRfVUxMKDAp
LCB9Ow0KPiArDQo+ICAgZW51bSByYXNfYmxvY2tfaWQgew0KPiAgICAgICBSQVNfQkxPQ0tfSURf
X1VNQyA9IDAsDQo+ICAgICAgIFJBU19CTE9DS19JRF9fU0RNQSwNCj4gQEAgLTEyNyw2ICsxMzEs
MTYgQEAgZW51bSByYXNfZ3B1X3N0YXR1cyB7DQo+ICAgICAgIFJBU19HUFVfU1RBVFVTX19JU19W
RiA9IDB4OCwNCj4gICB9Ow0KPg0KPiArZW51bSByYXNfZndfZWVwcm9tX2NtZCB7DQo+ICsgICAg
IFJBU19TTVVfR2V0UkFTVGFibGVWZXJzaW9uID0gMCwNCj4gKyAgICAgUkFTX1NNVV9HZXRCYWRQ
YWdlQ291bnQsDQo+ICsgICAgIFJBU19TTVVfU2V0VGltZXN0YW1wLA0KPiArICAgICBSQVNfU01V
X0dldFRpbWVzdGFtcCwNCj4gKyAgICAgUkFTX1NNVV9HZXRCYWRQYWdlSXBpZCwNCj4gKyAgICAg
UkFTX1NNVV9FcmFzZVJhc1RhYmxlLA0KPiArICAgICBSQVNfU01VX0dldEJhZFBhZ2VNY2FBZGRy
LA0KPiArfTsNCj4gKw0KPiAgIHN0cnVjdCByYXNfY29yZV9jb250ZXh0Ow0KPiAgIHN0cnVjdCBy
YXNfYmFua19lY2M7DQo+ICAgc3RydWN0IHJhc191bWM7DQo+IEBAIC0xNDEsNiArMTU1LDEwIEBA
IHN0cnVjdCByYXNfbXAxX3N5c19mdW5jIHsNCj4gICAgICAgICAgICAgICAgICAgICAgIHUzMiBt
c2csIHUzMiAqY291bnQpOw0KPiAgICAgICBpbnQgKCptcDFfZHVtcF92YWxpZF9iYW5rKShzdHJ1
Y3QgcmFzX2NvcmVfY29udGV4dCAqcmFzX2NvcmUsDQo+ICAgICAgICAgICAgICAgICAgICAgICB1
MzIgbXNnLCB1MzIgaWR4LCB1MzIgcmVnX2lkeCwgdTY0ICp2YWwpOw0KPiArICAgICBpbnQgKCpt
cDFfc2VuZF9lZXByb21fbXNnKShzdHJ1Y3QgcmFzX2NvcmVfY29udGV4dCAqcmFzX2NvcmUsDQo+
ICsgICAgICAgICAgICAgICAgICAgICBlbnVtIHJhc19md19lZXByb21fY21kIGluZGV4LCB1aW50
MzJfdCBwYXJhbSwgdWludDMyX3QgKnJlYWRfYXJnKTsNCj4gKyAgICAgaW50ICgqbXAxX2dldF9y
YXNfZW5hYmxlZF9tYXNrKShzdHJ1Y3QgcmFzX2NvcmVfY29udGV4dCAqcmFzX2NvcmUsDQo+ICsg
ICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCAqZW5hYmxlZF9tYXNrKTsNCj4gICB9Ow0KPg0K
PiAgIHN0cnVjdCByYXNfZWVwcm9tX3N5c19mdW5jIHsNCg0K
