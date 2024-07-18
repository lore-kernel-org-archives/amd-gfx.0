Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B649C3DA60
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 05:38:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32AF710E538;
	Thu, 18 Jul 2024 05:38:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OfBaw8Ce";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6ACA10E538
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 05:38:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fn3GjnLnd0lz8Z1Wj0+h+vpDQI9wn7u56c+Q51ii6YrTpvb+M1HfKelJBrkNS2SoV2Irg02BfinMyx2bOejfu0ckpC+pbPD31sMeuWtW2NTDz0n4LDdVCIorcp0tLPWPOGXFs+KIzw7RumnBFWYdRE2HTQ1uMCtzu17ceuHAVwrc+qx8aCPZTM6J1s9O6JUmjdw8O/WiRxhAGJ/Djczpy/MP0BQiqDoMGFQUhYNkoOEq9a+lI0m57teEcbnfTyUKi1uKcigmjEkEv/NL/Q4DeOwmnzTdG4ees7SiXrmAc8Wm2RE512Rsn/kPCrDKbGERrB4A8DVVfpS5+0TnXef0bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQpu75bwJ419ZYM77SX/jIQ25LmpCWxBkRQeqX+4cW4=;
 b=AbNguFmc8Mo9skzTT3vFhINSVIVw5DmKGokxmDU9D+IHjuE4q1Q8S6r0cGJi/l9yYAtrvNGAtNSzYmgQA1FxAUUwn27SPmDyHiYONFCb1Nd9mLQqW5gik8XFrsEEUC+heuJOqhBF7pBTPRv2dkW1iCZsTo9jaSvHBfHjo6/esxjgK6i8ymh/W3/PzMTng3Xzn+XtFbBJPzM6clw71o88ZpLdhXIxW+0b9RRow35ub9HZwJ8ZtoC9W61fAsMqgZUmX7zk0vtB+GWEit9H3xnNnCFwO5Eq9ghV2NEDZ/l2PHIlazVVNt7SEzzJFuC9O1DH8WY9tZTuuXOFzWtOkyE54Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQpu75bwJ419ZYM77SX/jIQ25LmpCWxBkRQeqX+4cW4=;
 b=OfBaw8CemeEJhO6wJYBSv3go+BnvrcNzgZ1Vnr2iZjTNqUa7kfaIofXg1iUpFHYRm/IoTjz5/lfiJo/Io50ST+cFYN2bmB7ariyvYDeZTRn3O3rdPTqWV+dC9PkN3BjK0krl6YwOhyc8biur1Yb3bZSxwznMdGYpqvJznKRDMKk=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SJ2PR12MB8651.namprd12.prod.outlook.com (2603:10b6:a03:541::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 18 Jul
 2024 05:38:52 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.7762.027; Thu, 18 Jul 2024
 05:38:52 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: optimize logging deferred error info
Thread-Topic: [PATCH 2/3] drm/amdgpu: optimize logging deferred error info
Thread-Index: AQHa2CGZzRuewd00l0aepnpp4M9IJbH7y+rQgAAK0YCAABBbgIAAEPOA
Date: Thu, 18 Jul 2024 05:38:52 +0000
Message-ID: <PH7PR12MB8796FEA628053561D0046F6AB0AC2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240717081547.224193-1-YiPeng.Chai@amd.com>
 <20240717081547.224193-2-YiPeng.Chai@amd.com>
 <PH7PR12MB87965FE14B4B083B38E3CDBDB0AC2@PH7PR12MB8796.namprd12.prod.outlook.com>
 <CH2PR12MB42159F3051B2254E1A5740C5FCAC2@CH2PR12MB4215.namprd12.prod.outlook.com>
 <CH2PR12MB42151D081B5DA967A7F58B93FCAC2@CH2PR12MB4215.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB42151D081B5DA967A7F58B93FCAC2@CH2PR12MB4215.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7c3021fd-db53-4b87-840f-056fb3730b62;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-18T02:56:30Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SJ2PR12MB8651:EE_
x-ms-office365-filtering-correlation-id: 7c11b6d3-6386-433e-2f86-08dca6ebe818
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+rHj1HK5jwbSrmKo91vySo+wVpElleO1zjvNUgYjn0C8gOC7E2UszGRDcQwS?=
 =?us-ascii?Q?U68MIRLy5eHpM/itJJyAfIBI7Y19Yc46J1oJ7+qmpEJzxsUPYtx9KmWBi+Wq?=
 =?us-ascii?Q?nnRb572nWr1KPjTtKdpqwI5Ub2wpnFyWenf75gKw0hWs7rRvZbBp7PCbgkLc?=
 =?us-ascii?Q?JOpF9Ev1p//gypQETfLl9ATp0grEYkSxr4l2VadYzL7SlDZc7Ha6awsJo40T?=
 =?us-ascii?Q?UaZRkRb5wbnAYNU4phS9aYizDAxoFdYsj7eBhZvDf/A6oOtcKP7yZbjYhbcc?=
 =?us-ascii?Q?smv/M1JzA8EHoUgr+yq24owhiG+OdWgrZ+Bvknq+AtX/Qw9RW0NPMEWjdGvV?=
 =?us-ascii?Q?8ahRZLTxOAV4FKzCo6IL6Z8W74FO7HT/9vLR0lm1vNz2owF08e2molL9pxIJ?=
 =?us-ascii?Q?SzPKCizXi8SyRL9xQnpqMGWWCVlJ3UIsIpTjZljph+T9S1c0szzgzkJ3N7n9?=
 =?us-ascii?Q?ZrPca1KGolrD07LCFTI7TwW2O03P/COVzlHQ41U+QmMcGes6OCrLUmL+08dY?=
 =?us-ascii?Q?uYBK8NUPo4xyq2fY9vsCsaLJ4FpxpoaYCV/EcyqhOFbx7w9HzKL4QK8CxXbO?=
 =?us-ascii?Q?AN9sBu4gQ+/zbgsh9Elltc1E16aN388bModPMilVKtwKzXLXAVi6zDVDI3TS?=
 =?us-ascii?Q?W+VHCRQmZjIpQAkiYh7uPCg0oIRt/nb0qKLfbQh1/HE9+9G3qjFQQ1RpeiRd?=
 =?us-ascii?Q?Gsa2uuZxno1tIsByTXWYh/LVJfrPLdej11ILdEk9g379IpIZqpkMTyKPkFnh?=
 =?us-ascii?Q?GQMmdkPtHTX1/p1iTNszc2ZgsVDrOm7MI+g1mYCn6ISUqNG0N3IDNapjICTg?=
 =?us-ascii?Q?Un+dmmYOsE7LszSJxtCZVQEKylDzHgjYkddhgX6xzo1n2sIeEHWM6aS+079m?=
 =?us-ascii?Q?xOE8k+06RU6tQoznrZNcf3hxL6yFIboC1pMcVpYrF3VyIdi2u/S+bk3if+Q5?=
 =?us-ascii?Q?8VgwXbPhfCyrCSDBAH9wziNwSEoVti+7w2O5+5LIwtzTDfuTQ3TWPWHQUuHI?=
 =?us-ascii?Q?eDXP/jMBq6b9SuKQS5OwNt4ZhcRar1U3jEbY/vB90nVzv1xxQlaXW/TOPIy8?=
 =?us-ascii?Q?qnPAY5N1bCFXRcOaqT5OBgKmZObSV1ro453R57Yu1CZu+DNtCE30gjRgzw7r?=
 =?us-ascii?Q?LVDdA4QXfOaWnlS/lhZt4UC0V2+wIPqNWyQvrApxo7g+t6+fYF9BcqE53feU?=
 =?us-ascii?Q?07BOr1ZYBihcbt5tp1xtexF1p+gs6Vc2AzlarlAQhMzlpSpwC5XnwRnfb5ad?=
 =?us-ascii?Q?193Im6rcgbyyI9pFTa9EPWP+5ltwWlo7JAtiU8TNSu1YlZ7dEaHNFUvUM6rk?=
 =?us-ascii?Q?/4aVAsuIAPe5QqCKjTLyzLRPfYNPeR2PQ1jc0oZ8aEV+s6lqP3npXh1Hxy8S?=
 =?us-ascii?Q?gKMUijyu4Zv7mg226Vmq0VpQEVn4WlkElhxOTiBk1iPHTFflkg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KcwxLEZYIwE+TleDIaomLbK+CnIddZN3RmEmfSloLAbrWnD948zmeKGDGGaW?=
 =?us-ascii?Q?ntwttNGPI9yUOAMNqabiqH04SdAQTOKBiy6y5V61mdiUaS2sqJvVaL4//Nk6?=
 =?us-ascii?Q?dMdkvPlbp+CaUHkMU6dbtLzda96QYubSkttsw6Q8vTRkFRGoiOpvXr8EC1mJ?=
 =?us-ascii?Q?Z3/bNRyQOIkBhAj2pxjMr5Cllg5pkzezLNbbnOxGeTk+Em+kABth2BxFqvkH?=
 =?us-ascii?Q?CgKV2ZDsu5QE2lXfPs7Hab/d+vmCarjtf0c900VRYSMoIAf0xcXKIUGmlQft?=
 =?us-ascii?Q?oNTSi3sE4+hRGSiFyR3a7YwPp3HVBPP44Lv2BuiyR7SO8GdH2vje2RMXvKNu?=
 =?us-ascii?Q?VbFim5vMEZPWt6kdBqSz4R1BwoR44ltn3WgVPrSNDHXVfdw979WxDf2ryPMA?=
 =?us-ascii?Q?S6wyBv4TeBJsPxoet5d2iCqFjDB23aSRbmvauhYwdRFf821EpSDD4inH8Srm?=
 =?us-ascii?Q?+zcYYjcNKbuwbiLtuMnyuVth8N5AXyHPHBRQMln5kLH/NoDv7VpiXBCMtJYe?=
 =?us-ascii?Q?sG4tczTRs7nmD9z/IC+MDmeCdWs/hugzDZSgYNQv5iiGkAI7bwRoB2J9Mx52?=
 =?us-ascii?Q?pbz/Z3TNn3Za9/BR7r2j1xsIdY8STWT/O5ZCW4jqEx/tPcAjNUmVv0UVOgHJ?=
 =?us-ascii?Q?4H70/HpS8aapLo3qMbQj74jg0Tmk905JFPsaVS3YNH277QW2SXDMyb3vgFBg?=
 =?us-ascii?Q?o+X2acE8w6Xz+BgmoxrMGqQDunM7qmVrdKGafjFXBiElGs0j+jEYKcIy5ziL?=
 =?us-ascii?Q?3ZQvPQyFbqjcbq54hQyffqLfWDMxPMu6keeDjs74AmXFbBa+o/T1kXfc7Ye6?=
 =?us-ascii?Q?gdYdNlTJ+Qt6AK4H4j6Gs31UfP2GW/aUnmSNf3NqBWNi9SlckHTLFKC4XfQz?=
 =?us-ascii?Q?2WIDImoJVJJgSDn5rDkNxFyhayOXXQmCJt6yt+3eKUMtYhdEhLkCH4TKqo/Q?=
 =?us-ascii?Q?ib9DSByV00IlJdCEvkdPbcJczdgFhBtMf81rzOWULgq1yZVsD6W063VJl3bg?=
 =?us-ascii?Q?n5Wbrmp8IQG7g67rwvoNR+sNTe2hs4BUyZtsHn+Eln8O0fqDMOnKbeGmakso?=
 =?us-ascii?Q?4i149xkJDjxM92XrbJH9X9L1ZELCy3McmwaPg019qxeXG45hjGWOrKy+vPkx?=
 =?us-ascii?Q?iKwH8tDHbLKpNIFqS1m/PQUKUiNo/0rTuMgEMIFVXEd0oS9T3dbf5KSSwX7l?=
 =?us-ascii?Q?vSZdPxXdgY4m0A4c5p8KXTMf67NXZPNSgJoUViXnzfGd7HOjUza73XjbBnjR?=
 =?us-ascii?Q?I25navFJW5KgwgrdyeLCWRW2Nvp4DPSNtzbPeMMSVb1V3LDHVMGAO7TgJZjb?=
 =?us-ascii?Q?1F3NqPJmpxvNvC1WLiq2SyM5/Fn4lJM38dnb+c4rw2Q05x4WBGoK2Qo3v7EG?=
 =?us-ascii?Q?A6jixj7zyhM4EaDa/Ev247hx01YhtaZCtR57QYbUV/6NpGpQ/iqCuMEbP5ZF?=
 =?us-ascii?Q?W10TFBwzzRcNDNs579V4yCqqoWrCChPEndwWPj0B9PP1b6HshrkBkleJwlvs?=
 =?us-ascii?Q?gdXvSRFincF2xPI9cUIrtbLbHDSAS9CpPY4AIMSN5qplqMDtrb6/xCYywOuW?=
 =?us-ascii?Q?xz+Cma7Dis+a+OrabPM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c11b6d3-6386-433e-2f86-08dca6ebe818
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 05:38:52.0773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SKNDV9IhHO4mpimo6tY5Slta9pOU+CbJonDV1EhZIjMs2i7OxlgRa/hWgif7QTyB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8651
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

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Thursday, July 18, 2024 12:34 PM
> To: Chai, Thomas <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;
> amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH 2/3] drm/amdgpu: optimize logging deferred error info
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----------------
> Best Regards,
> Thomas
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Chai,
> Thomas
> Sent: Thursday, July 18, 2024 11:35 AM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH 2/3] drm/amdgpu: optimize logging deferred error info
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----------------
> Best Regards,
> Thomas
>
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Thursday, July 18, 2024 10:57 AM
> To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH 2/3] drm/amdgpu: optimize logging deferred error info
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: Chai, Thomas <YiPeng.Chai@amd.com>
> > Sent: Wednesday, July 17, 2024 4:16 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> > <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang,
> > Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley
> > <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> > Subject: [PATCH 2/3] drm/amdgpu: optimize logging deferred error info
> >
> > 1. Use pa_pfn as the radix-tree key index to log
> >    deferred error info.
> > 2. Use local array to store expanded bad pages.
> >
> > Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 +-
> > drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 14 ++----
> > drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 65 ++++++++++++-------------
> > drivers/gpu/drm/amd/amdgpu/umc_v12_0.h  |  5 ++
> >  4 files changed, 40 insertions(+), 46 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > index dcf1f3dbb5c4..f607ff620015 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > @@ -476,10 +476,10 @@ struct ras_err_pages {  };
> >
> >  struct ras_ecc_err {
> > -     u64 hash_index;
> >       uint64_t status;
> >       uint64_t ipid;
> >       uint64_t addr;
> > +     uint64_t pa_pfn;
> >       struct ras_err_pages err_pages;
> >  };
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > index 5d08c03fe543..2fc90799bf8d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > @@ -523,18 +523,10 @@ int amdgpu_umc_logs_ecc_err(struct
> amdgpu_device
> > *adev,
> >       ecc_log =3D &con->umc_ecc_log;
> >
> >       mutex_lock(&ecc_log->lock);
> > -     ret =3D radix_tree_insert(ecc_tree, ecc_err->hash_index, ecc_err)=
;
> > -     if (!ret) {
> > -             struct ras_err_pages *err_pages =3D &ecc_err->err_pages;
> > -             int i;
> > -
> > -             /* Reserve memory */
> > -             for (i =3D 0; i < err_pages->count; i++)
> > -                     amdgpu_ras_reserve_page(adev, err_pages->pfn[i]);
> > -
> > +     ret =3D radix_tree_insert(ecc_tree, ecc_err->pa_pfn, ecc_err);
> > +     if (!ret)
> >               radix_tree_tag_set(ecc_tree,
> > -                     ecc_err->hash_index,
> > UMC_ECC_NEW_DETECTED_TAG);
> > -     }
> > +                     ecc_err->pa_pfn, UMC_ECC_NEW_DETECTED_TAG);
> >       mutex_unlock(&ecc_log->lock);
> >
> >       return ret;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> > b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> > index eca5ac6a0532..f2235c9ead29 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> > @@ -524,9 +524,9 @@ static int umc_v12_0_update_ecc_status(struct
> > amdgpu_device *adev,
> >       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> >       uint16_t hwid, mcatype;
> >       uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
> > -     uint64_t err_addr, hash_val =3D 0, pa_addr =3D 0;
> > +     uint64_t err_addr, pa_addr =3D 0;
> >       struct ras_ecc_err *ecc_err;
> > -     int count, ret;
> > +     int count, ret, i;
> >
> >       hwid =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
> >       mcatype =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType); @@ -559,3=
9
> > +559,18 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device
> > *adev,
> >       if (ret)
> >               return ret;
> >
> > -     memset(page_pfn, 0, sizeof(page_pfn));
> > -     count =3D umc_v12_0_expand_addr_to_bad_pages(adev,
> > -                             pa_addr,
> > -                             page_pfn, ARRAY_SIZE(page_pfn));
> > -     if (count <=3D 0) {
> > -             dev_warn(adev->dev, "Fail to convert error address!
> > count:%d\n", count);
> > -             return 0;
> > -     }
> > -
> > -     ret =3D amdgpu_umc_build_pages_hash(adev,
> > -                     page_pfn, count, &hash_val);
> > -     if (ret) {
> > -             dev_err(adev->dev, "Fail to build error pages hash\n");
> > -             return ret;
> > -     }
> > -
> >       ecc_err =3D kzalloc(sizeof(*ecc_err), GFP_KERNEL);
> >       if (!ecc_err)
> >               return -ENOMEM;
> >
> > -     ecc_err->err_pages.pfn =3D kcalloc(count, sizeof(*ecc_err->err_pa=
ges.pfn),
> > GFP_KERNEL);
> > -     if (!ecc_err->err_pages.pfn) {
> > -             kfree(ecc_err);
> > -             return -ENOMEM;
> > -     }
> > -
> > -     memcpy(ecc_err->err_pages.pfn, page_pfn, count * sizeof(*ecc_err-
> > >err_pages.pfn));
> > -     ecc_err->err_pages.count =3D count;
> > -
> > -     ecc_err->hash_index =3D hash_val;
> >       ecc_err->status =3D status;
> >       ecc_err->ipid =3D ipid;
> >       ecc_err->addr =3D addr;
> > +     ecc_err->pa_pfn =3D UMC_V12_ADDR_MASK_BAD_COLS(pa_addr) >>
> > +AMDGPU_GPU_PAGE_SHIFT;
> > +
> > +     /* If converted pa_pfn is 0, use pa xor pfn. */
> > +     if (!ecc_err->pa_pfn)
> > +             ecc_err->pa_pfn =3D BIT_ULL(UMC_V12_0_PA_R13_BIT) >>
> > +AMDGPU_GPU_PAGE_SHIFT;
>
> >[Tao] why address 0 should be avoided?
>
> [Thomas] When address is 0, it means the data has just been loaded from
> EEPROM, it should calculate  pa_pfn.   This will be useful for the eeprom=
 new data
> formats in  the future.

[Tao] better not to rely on this rule, R13 shift requirement comes from HBM=
 provider.

>
> >
> >       ret =3D amdgpu_umc_logs_ecc_err(adev, &con-
> > >umc_ecc_log.de_page_tree, ecc_err);
> >       if (ret) {
> > @@ -600,13 +579,25 @@ static int umc_v12_0_update_ecc_status(struct
> > amdgpu_device *adev,
> >               else
> >                       dev_err(adev->dev, "Fail to log ecc error!
> > ret:%d\n", ret);
> >
> > -             kfree(ecc_err->err_pages.pfn);
> >               kfree(ecc_err);
> >               return ret;
> >       }
> >
> >       con->umc_ecc_log.de_queried_count++;
> >
> > +     memset(page_pfn, 0, sizeof(page_pfn));
> > +     count =3D umc_v12_0_expand_addr_to_bad_pages(adev,
> > +                             pa_addr,
> > +                             page_pfn, ARRAY_SIZE(page_pfn));
> > +     if (count <=3D 0) {
> > +             dev_warn(adev->dev, "Fail to convert error address!
> > count:%d\n", count);
> > +             return 0;
> > +     }
> > +
> > +     /* Reserve memory */
> > +     for (i =3D 0; i < count; i++)
> > +             amdgpu_ras_reserve_page(adev, page_pfn[i]);
> > +
> >       /* The problem case is as follows:
> >        * 1. GPU A triggers a gpu ras reset, and GPU A drives
> >        *    GPU B to also perform a gpu ras reset.
> > @@ -631,16 +622,21 @@ static int umc_v12_0_fill_error_record(struct
> > amdgpu_device *adev,
> >                               struct ras_ecc_err *ecc_err, void
> > *ras_error_status)  {
> >       struct ras_err_data *err_data =3D (struct ras_err_data *)ras_erro=
r_status;
> > -     uint32_t i =3D 0;
> > -     int ret =3D 0;
> > +     uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
> > +     int ret, i, count;
> >
> >       if (!err_data || !ecc_err)
> >               return -EINVAL;
> >
> > -     for (i =3D 0; i < ecc_err->err_pages.count; i++) {
> > +     memset(page_pfn, 0, sizeof(page_pfn));
> > +     count =3D umc_v12_0_expand_addr_to_bad_pages(adev,
> > +                             ecc_err->pa_pfn <<
> > AMDGPU_GPU_PAGE_SHIFT,
> > +                             page_pfn, ARRAY_SIZE(page_pfn));
> > +
> > +     for (i =3D 0; i < count; i++) {
> >               ret =3D amdgpu_umc_fill_error_record(err_data,
> >                               ecc_err->addr,
> > -                             ecc_err->err_pages.pfn[i] <<
> > AMDGPU_GPU_PAGE_SHIFT,
> > +                             page_pfn[i] << AMDGPU_GPU_PAGE_SHIFT,
> >                               MCA_IPID_2_UMC_CH(ecc_err->ipid),
> >                               MCA_IPID_2_UMC_INST(ecc_err->ipid));
> >               if (ret)
> > @@ -674,7 +670,8 @@ static void
> > umc_v12_0_query_ras_ecc_err_addr(struct
> > amdgpu_device *adev,
> >                       dev_err(adev->dev, "Fail to fill umc error
> > record, ret:%d\n", ret);
> >                       break;
> >               }
> > -             radix_tree_tag_clear(ecc_tree, entries[i]->hash_index,
> > UMC_ECC_NEW_DETECTED_TAG);
> > +             radix_tree_tag_clear(ecc_tree,
> > +                             entries[i]->pa_pfn,
> > UMC_ECC_NEW_DETECTED_TAG);
> >       }
> >       mutex_unlock(&con->umc_ecc_log.lock);
> >  }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
> > b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
> > index b4974793850b..be5598d76c1d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
> > @@ -81,6 +81,11 @@
> >       (((REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo) & 0x1) << 2) |=
 \
> >        (REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi) & 0x03))
> >
> > +#define UMC_V12_ADDR_MASK_BAD_COLS(addr) \
> > +     ((addr) & ~((0x3ULL << UMC_V12_0_PA_C2_BIT) | \
> > +                     (0x1ULL << UMC_V12_0_PA_C4_BIT) | \
> > +                     (0x1ULL << UMC_V12_0_PA_R13_BIT)))
> > +
> >  bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t
> > mc_umc_status);  bool umc_v12_0_is_uncorrectable_error(struct
> > amdgpu_device *adev, uint64_t mc_umc_status);  bool
> > umc_v12_0_is_correctable_error(struct amdgpu_device *adev, uint64_t
> > mc_umc_status);
> > --
> > 2.34.1
>
>

