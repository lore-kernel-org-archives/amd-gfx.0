Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A484C5DF6D
	for <amd-gfx@archiver.kernel.org>; Sun, 16 Aug 2026 17:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDB2010E2AD;
	Sun, 16 Aug 2026 17:07:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QsxHk2wo";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010023.outbound.protection.outlook.com [52.101.85.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54B1D10E2AD
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Aug 2026 17:07:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ek50+YRwCLU0OnhszOEtaMl2zVmASdAAlwd4ZM4PgXk8yG63oA1t3J4ZoRxiXx1eJqerZAHnphhFKChb5J1yxG58ElNKBtSDMt1QniQVu0cM0P0eaHngSpGWBMF9QEKf3uO7N9mE+qUSAoDFlfUmnfZoohx5NPqZcMO+qLbvch1DlmxUfCtMZ7o1U3Z5MPlqfz2MeIbPWZVIvkTBFjug5+EHJJdYgDnXSQfai3NwRDjSx9NNcwmJC8Oqe6QttGZjTittzxpT35fZXEhZyTvGKbEV4D2MoZkWBksKPzBAnePDX6gLxXJZKxuCmNexEmnjqp6unmwwZufYJj5rMmz3lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbDQz+8HqGa6QQUEUSH///b4oYWrpMSudBMAJljhjBw=;
 b=MKtQmWpuDOTPVX2pI3qWeqKqEGneEyrg5VsGq9B1xMlrrxEldswV/IzbI/V6Y+0h+ghASjZkXkjdVgswLIl+hDf++BCNO8lu2AUF+lkTOlcNx1gxKgEmHzA3Uy59Ea09YWm+VbHU3NGqTmhgPRnWLQVJvMRM39aa5PHy2k960CvxMXt/SwewpykARpos2v3z5mTOLC9sbloNJ5j7Lu483JPcoeOX5BIkLGnHE3Ms4bWufPxxAL7wjq2cvLMqvtPRbc3T/3pKm0uOwApqZ/ojArGIh2dNjKSX/kEgelu3pn0rBw3iC3oSRXNbFHyNSiFewQuxAT6t0xjC8b63UDOwRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbDQz+8HqGa6QQUEUSH///b4oYWrpMSudBMAJljhjBw=;
 b=QsxHk2wo1lgh6fP9bPRnVzrUcl6M4/qXQO5lG4ytrTAJglTbBL5P2gAQwYmrVioUyS1fwdtE6yCZ0pFfL0tz2LGDtjlLZZ5cEeALQAbNri1lxkw6rM2nRl32Vnxo9pzzoDRaWHyyaw9OiDWvnserOueQ9hm+UBIuBQP6Q7B4dnQ=
Received: from IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5)
 by MN0PR12MB5738.namprd12.prod.outlook.com (2603:10b6:208:371::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 17:07:38 +0000
Received: from IA0PR12MB8895.namprd12.prod.outlook.com
 ([fe80::904a:1cfc:7595:522]) by IA0PR12MB8895.namprd12.prod.outlook.com
 ([fe80::904a:1cfc:7595:522%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 17:07:38 +0000
From: "Hosur, Priya" <Priya.Hosur@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>, "Gopalakrishnan,
 Veerabadhran (Veera)" <Veerabadhran.Gopalakrishnan@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue
 unmap
Thread-Topic: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue
 unmap
Thread-Index: AQHdLAim0YA7X1/aUkizBVDzj4MR0badvBMAgAAFJACAAAqZAIADHtmw
Date: Sun, 16 Aug 2026 17:07:37 +0000
Message-ID: <IA0PR12MB8895E3ADC3692524015EDC2AF3D82@IA0PR12MB8895.namprd12.prod.outlook.com>
References: <20260814161841.5906-1-Priya.Hosur@amd.com>
 <20260814161841.5906-3-Priya.Hosur@amd.com>
 <SA0PR12MB7091D3AE34006DC6797EECD197DA2@SA0PR12MB7091.namprd12.prod.outlook.com>
 <DS5PPF78FC67EBA848622BC6037F917872992DA2@DS5PPF78FC67EBA.namprd12.prod.outlook.com>
 <SA0PR12MB7091F549BC02FFD7312367AF97DA2@SA0PR12MB7091.namprd12.prod.outlook.com>
In-Reply-To: <SA0PR12MB7091F549BC02FFD7312367AF97DA2@SA0PR12MB7091.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-14T16:47:49.7760000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8895:EE_|MN0PR12MB5738:EE_
x-ms-office365-filtering-correlation-id: cfe65344-bb23-4a3c-0cd1-08defbb8dfd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|56012099006|8096899003|38070700021|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info: bxWMd98XHBrP1ABI47vq9S0n+srUJaMMY5W91S3rPM37H6/Wh7ttxV9IFSrt5mvEC+gE52tj2zNw7S9WCO9t2bnirYp/+/2uyFfd1J1WssnkkUFJA8P23Pc9EZROtq18TISpoK8ZBCMNX0Tyg6Xiz557lHTwvKKz59Jz5bjBycSizERR3E1BfsymUupOs9kShqyndspL4CVtQ8RB+W0HLAjNZyqCtEzseA8/RRtjWZFavetjHP8V2sVoksTFsA6rWboTqmrsnfWCE0iAfqhp9s37IsGpLnmGNGKgr6t6yVgz7E74Y7SZgb34GZGdVyNvtsWcnH6QK4y032SWvwN6si8vutQalic6mrXN9WCHfE/MJ6obJLVCXzOD03/MGrhnnnb3C+k+sX8yWQMnkd3mWNs1bSfHXfIl4Uxnkc38yK0Rib2V+mQz6Lj5cxJdMuwxv05v/lN8CmWD4uytI1dmUkFkbHFtz2kv9RZ+8KFQhKxSieAZziJ1klZWEvjr5qd76vLSW+2fv//hO6jLRC03r32PL0yrufE9cncJQnXzrk2A4STGMDSwUs+5BUOVjZD7Gwj3JHQYUzV21hFmRWvCGyOZXf7kTff+TwWJpOjUKMXt77VTfpLX4kRNWZMaRcLpSCSr5wkIycb38ih0E6BIL2qZy1kRVrjTLp4YUXKmhjxM73mLhiIUZeTt+8xIF2POVm2zN+UHJly34u9HKfnBJ+wBL/uF6O/jXrirCxi07IM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8895.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(8096899003)(38070700021)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R0kUIiOp8Sx9jUvFl7MqBJJc41wI7OS2xYU7ZnLffcOxazU2FjnmEXWmDOKu?=
 =?us-ascii?Q?ZoR6hMgXZToYU0BWVYvc+t1LxGIpRn3qRYvJnjmhrdahAWtxOkA/F9X59lIE?=
 =?us-ascii?Q?sweuUDf9TaIJkSO2s3uaAnmN7hXbmCDeEqA0IvaeA5HrXfAbbN6kQOwUqbLg?=
 =?us-ascii?Q?LRJwbfaaxIcdIWPCjvHCBbsGJjjR0J84fOQrJjbjSFsHTCbrOzQTIgeXKKU5?=
 =?us-ascii?Q?+brpSaFn6OQfKN0RyCez3IfjwhbJtNhYJq9Z9N4+ag9MB9/I62sZACcDmkUp?=
 =?us-ascii?Q?ocVn/YpkuQUOSv3s7ARWtTDIhSRmMfAuMlq6aQ7TYp1YKIeK02imCJTf9VMB?=
 =?us-ascii?Q?K/Lx54Hu73Hq/FsINSWqhO4StNfWozYZJ6bVsuJ5zckT8dYxmwAVV0r+g89U?=
 =?us-ascii?Q?R8jI/9SCyitVKvYedT0vOUQoZq8hHtrUFQ7MVPQjAaYiQUqbCwNfTCYO8Mgf?=
 =?us-ascii?Q?TW7OYqNpoz/Hp6mH1fxhUEkWR/Av8NBPQo3JZrs/VvLFFWfyhNnhEUcU2ZD4?=
 =?us-ascii?Q?0/o6CI52l1GWU0DBdFy+FxWS40FeM7jJDnRsYv9NwKo87G1wDY94dudib26d?=
 =?us-ascii?Q?iOycTUglApj9MNKYvPpEeSuCF5jGTBD4w+pyccwFOvWxi7i4db2RlDwXZvN+?=
 =?us-ascii?Q?T0ENXPOU7/VEvMxIVlzV+j6aMgVsK8EQHl/KOE3T2m1WEgJAY90gbpGTc3pH?=
 =?us-ascii?Q?3gIUQnQOOQnsUeMwb0GDsuthPyB/ZyJLVynjVTHUGgHn9LJ7F8e8q0ZN1S8M?=
 =?us-ascii?Q?4nHDdXV3Ss2mdSsaH1WNURIqFz+S9KcCWlZHwMnUEsHgfS4quKAd7ff9qzFt?=
 =?us-ascii?Q?48ukPHfeuIIE46uAAw/wYi16Capxyw4y314dTbIHiejkMW/70HA16yGx0L0c?=
 =?us-ascii?Q?7P/dDC3eGML9O7LgBRsjpRGSzPcMAW8udmPQn8Z5AsPwJ60zhRqcbx0m/W85?=
 =?us-ascii?Q?tRQrWi5FONrgpRg5OIw87w+fcgAlMnTCCwcZtm2+r20TMb7E/GR1r6RQ2fur?=
 =?us-ascii?Q?7Av+moifliawbgPgZjhPrpe9Wfss16T7mBFf2gjpRGqSZvip+g2C+R8LYzhw?=
 =?us-ascii?Q?sgsThmT1zGFZsCGdwOGmAIOOPB871NWZSh93gdAZVoG3IWXC0GkNTkacqhPl?=
 =?us-ascii?Q?v8jNa5adgICJ2I1ZN7YmksqPuthJ9emy5MweFY2lD4t6rqhZAQjWyn76zqs8?=
 =?us-ascii?Q?Qc9WprCdwyN+fH0FD2s3niyIa2g1fySY5UbWZRevIY9tmS5M/JYgJ6oC6IEt?=
 =?us-ascii?Q?kM5YoXkGD4seSdn1ZCcF3jfaYW7jvPHIaTSDrsI4f/S7SNbSO3X2qyYHN5pq?=
 =?us-ascii?Q?Ygh1bYyn7cISTLBaGtnDiAwquvod3nr2fmlALyVU0kq1L1iR6W99u1PmYnU+?=
 =?us-ascii?Q?rxJjYyPz8rA7s7fFGANv63d5uk4VdK6IbQWA/Jm7Mobsxfhy/ScGpqLrarij?=
 =?us-ascii?Q?Ds8JWWX4OHL7QrjlUJ/oomMWfBcsFlB+rt+wIClsyhtVpnYc57/Lb2WWRdCO?=
 =?us-ascii?Q?O7PbZXbOW96iuy5DKNNfEE1OCVbHpr4+Fjcawigk4EN7hgBXqaUkuQy2fe2X?=
 =?us-ascii?Q?a7/PY9GAURekP5JO9R3R5SYlWgW93upLVRUGR7oBWjzQ4xCQ8kRPYqg6uU0/?=
 =?us-ascii?Q?Yc2Ks9MLUjKtoeTa3P2HuxF24PyisoqZ+adiCxF7ASmkSic6gJ25z/HdJxmx?=
 =?us-ascii?Q?edx65SFh8NQDe78PZE+PuzE7BRZYt5t6KWNWTbesQL/ECQEG?=
Content-Type: multipart/alternative;
 boundary="_000_IA0PR12MB8895E3ADC3692524015EDC2AF3D82IA0PR12MB8895namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe65344-bb23-4a3c-0cd1-08defbb8dfd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2026 17:07:38.0193 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2YFPE1agPINhqfSFWbLf8qP6fD+kjgsPk+rpBRxF7nT7YF1y+y7/am3qZzYpkJBQv4wAY1bTmuSqUKrLeOtprQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5738
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

--_000_IA0PR12MB8895E3ADC3692524015EDC2AF3D82IA0PR12MB8895namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Hi Felix, Lijo,

Thanks for the clarification. I understand now - TLB flush is only needed a=
fter batch queue unmapping (eviction/suspension), not after each individual=
 queue unmap.

Alex - based on Felix's feedback, the userq unmap path doesn't need the sam=
e fix since it's per-queue unmap rather than batch unmap.

I'll drop patch 2/2 (userq fix) and send v4 with only the KFD fix.

Thanks and Regards,
Priya Hosur

From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, August 14, 2026 10:56 PM
To: Kuehling, Felix <Felix.Kuehling@amd.com>; Hosur, Priya <Priya.Hosur@amd=
.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher=
@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Liu, Shaoyun <Shaoyun.Liu@=
amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; Koenig, Christian=
 <Christian.Koenig@amd.com>
Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Gopalakrishnan, Veera=
badhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue =
unmap


AMD General

Thanks for the details. Didn't realise that it is one by one removal. I tho=
ught it was something like unmap-all for a PAS id.

Thanks,
Lijo
________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Friday, 14 August 2026 22:17:50
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Hosur, Priya <Priya.Hosur@amd.com>; a=
md-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher, Alex=
ander <Alexander.Deucher@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Li=
u, Shaoyun <Shaoyun.Liu@amd.com>; Limonciello, Mario <Mario.Limonciello@amd=
.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Gopalakrishnan, Veera=
badhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue =
unmap

AMD General

We don't need to flush TLBs after every queue unmap. We only need to do it =
if there is an expectation that memory access is quiesced after unmapping. =
In the case of KFD, we are doing it when we're unmapping all queues, e.g. i=
n MMU notifiers, evictions or when the debugger needs to stop the queues an=
d look at memory contents. We only need one TLB flush after unmapping many =
queues.

Therefore, MES should flush TLBs after every queue unmap. OTOH, MES must fl=
ush TLBs by itself when it switches VMIDs. This is not under driver control=
.

I don't know what the requirements are for quiescing memory access after un=
mapping amdgpu user mode queues.

Regards,
  Felix
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, August 14, 2026 12:29
To: Hosur, Priya <Priya.Hosur@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>;=
 Khatri, Sunil <Sunil.Khatri@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.=
com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Limonciello, Mario <Mario.Limonci=
ello@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Gopalakrishnan, Veera=
badhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>; Hosur, Priya <Priya.=
Hosur@amd.com>
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue =
unmap


AMD General

Hi,

Shouldn't this be a FW fix?

Thanks,
Lijo
________________________________
From: Priya Hosur <Priya.Hosur@amd.com>
Sent: Friday, 14 August 2026 21:48:40
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com=
>; Kuehling, Felix <Felix.Kuehling@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.=
com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Limonciello, Mario <Mario.Limonciel=
lo@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Gopalakrishnan, Veera=
badhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>; Hosur, Priya <Priya.=
Hosur@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue unma=
p

Similar to the KFD fix, MES does not perform heavy-weight TLB
invalidation after unmapping user queues. Add
amdgpu_gmc_flush_gpu_tlb_pasid() after MES unmap succeeds in
amdgpu_userq_unmap_helper() to ensure in-flight memory accesses
complete before memory is freed or migrated.

Change-Id: I94fe2c84547723b6b73816ce8d727a54bd773a6a
Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.c
index 6d3ed55e9ab4..9fcf15d69b7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -375,6 +375,12 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_use=
rmode_queue *queue)
                 } else {
                         trace_amdgpu_userq_state_changed(queue, AMDGPU_USE=
RQ_STATE_UNMAPPED);
                         queue->state =3D AMDGPU_USERQ_STATE_UNMAPPED;
+                       /*
+                        * Heavy-weight TLB flush after MES unmaps queue to=
 ensure
+                        * in-flight memory accesses complete before memory=
 is freed/migrated.
+                        * MES does not do this automatically unlike HWS.
+                        */
+                       amdgpu_gmc_flush_gpu_tlb_pasid(adev, queue->vm->pas=
id, 2, true, 0);
                 }
         }

--
2.43.0

--_000_IA0PR12MB8895E3ADC3692524015EDC2AF3D82IA0PR12MB8895namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
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
AMD General<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Felix, Lijo,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks for the clarification. I understand now - TLB=
 flush is only needed after batch queue unmapping (eviction/suspension), no=
t after each individual queue unmap.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Alex - based on Felix's feedback, the userq unmap pa=
th doesn't need the same fix since it's per-queue unmap rather than batch u=
nmap.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I'll drop patch 2/2 (userq fix) and send v4 with onl=
y the KFD fix.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and Regards,<br>
Priya Hosur<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Lazar, Lijo &lt;Lijo.Lazar@amd=
.com&gt;
<br>
<b>Sent:</b> Friday, August 14, 2026 10:56 PM<br>
<b>To:</b> Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;; Hosur, Priya &lt=
;Priya.Hosur@amd.com&gt;; amd-gfx@lists.freedesktop.org; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Khatri, Sunil &lt;Sunil.Khatri@amd.com&=
gt;; Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; Limonciello, Mario
 &lt;Mario.Limonciello@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@=
amd.com&gt;<br>
<b>Cc:</b> Vishwakarma, Pratik &lt;Pratik.Vishwakarma@amd.com&gt;; Gopalakr=
ishnan, Veerabadhran (Veera) &lt;Veerabadhran.Gopalakrishnan@amd.com&gt;<br=
>
<b>Subject:</b> Re: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user=
 queue unmap<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"mso-margin-top-alt:0in;margin-right:5.0pt;margin-bottom:0in;mar=
gin-left:5.0pt;margin-bottom:.0001pt">
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
color:blue">AMD General<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"color:#212121">Thanks for the details=
. Didn't realise that it is one by one removal. I thought it was something =
like unmap-all for a PAS id.<o:p></o:p></span></p>
<div id=3D"ms-outlook-mobile-body-separator-line">
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div id=3D"ms-outlook-mobile-signature">
<p class=3D"MsoNormal"><span style=3D"color:#212121">Thanks,<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"color:#212121">Lijo<o:p></o:p></span>=
</p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Kuehli=
ng, Felix &lt;Felix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Friday, 14 August 2026 22:17:50<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Hosur, Priya &lt;Priya.H=
osur@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedeskt=
op.org&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Khatri, S=
unil &lt;Sunil.Khatri@amd.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;=
;
 Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; Koenig, Christian &l=
t;Christian.Koenig@amd.com&gt;<br>
<b>Cc:</b> Vishwakarma, Pratik &lt;Pratik.Vishwakarma@amd.com&gt;; Gopalakr=
ishnan, Veerabadhran (Veera) &lt;Veerabadhran.Gopalakrishnan@amd.com&gt;<br=
>
<b>Subject:</b> Re: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user=
 queue unmap</span>
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
<div style=3D"margin-left:5.0pt">
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:blue">AMD General<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;color:black">We don'=
t need to flush TLBs after every queue unmap. We only need to do it if ther=
e is an expectation that memory access is quiesced after unmapping. In the =
case of KFD, we are doing it when we're
 unmapping all queues, e.g. in MMU notifiers, evictions or when the debugge=
r needs to stop the queues and look at memory contents. We only need one TL=
B flush after unmapping many queues.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;color:black">Therefo=
re, MES should flush TLBs after every queue unmap. OTOH, MES must flush TLB=
s by itself when it switches VMIDs. This is not under driver control.<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;color:black">I don't=
 know what the requirements are for quiescing memory access after unmapping=
 amdgpu user mode queues.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;color:black">Regards=
,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;color:black">&nbsp; =
Felix<o:p></o:p></span></p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Lazar,=
 Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
<b>Sent:</b> Friday, August 14, 2026 12:29<br>
<b>To:</b> Hosur, Priya &lt;Priya.Hosur@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;; Deucher, Alexander &lt;Alexa=
nder.Deucher@amd.com&gt;; Khatri, Sunil &lt;Sunil.Khatri@amd.com&gt;; Kuehl=
ing, Felix &lt;Felix.Kuehling@amd.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@amd=
.com&gt;;
 Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; Koenig, Christian &l=
t;Christian.Koenig@amd.com&gt;<br>
<b>Cc:</b> Vishwakarma, Pratik &lt;Pratik.Vishwakarma@amd.com&gt;; Gopalakr=
ishnan, Veerabadhran (Veera) &lt;Veerabadhran.Gopalakrishnan@amd.com&gt;; H=
osur, Priya &lt;Priya.Hosur@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user=
 queue unmap</span>
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:blue">AMD General<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"color:#212121">Hi,<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"color:#212121"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#212121">Shouldn't this be a FW=
 fix?<o:p></o:p></span></p>
<div id=3D"x_x_ms-outlook-mobile-body-separator-line">
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div id=3D"x_x_ms-outlook-mobile-signature">
<p class=3D"MsoNormal"><span style=3D"color:#212121">Thanks,<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"color:#212121">Lijo<o:p></o:p></span>=
</p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Priya =
Hosur &lt;Priya.Hosur@amd.com&gt;<br>
<b>Sent:</b> Friday, 14 August 2026 21:48:40<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Khatri, Sunil &l=
t;Sunil.Khatri@amd.com&gt;; Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;;=
 Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.c=
om&gt;;
 Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; Koenig, Christian &l=
t;Christian.Koenig@amd.com&gt;<br>
<b>Cc:</b> Vishwakarma, Pratik &lt;Pratik.Vishwakarma@amd.com&gt;; Gopalakr=
ishnan, Veerabadhran (Veera) &lt;Veerabadhran.Gopalakrishnan@amd.com&gt;; H=
osur, Priya &lt;Priya.Hosur@amd.com&gt;<br>
<b>Subject:</b> [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user que=
ue unmap</span>
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">Similar to the KFD fix, MES does not perform heavy-weight TLB<b=
r>
invalidation after unmapping user queues. Add<br>
amdgpu_gmc_flush_gpu_tlb_pasid() after MES unmap succeeds in<br>
amdgpu_userq_unmap_helper() to ensure in-flight memory accesses<br>
complete before memory is freed or migrated.<br>
<br>
Change-Id: I94fe2c84547723b6b73816ce8d727a54bd773a6a<br>
Signed-off-by: Priya Hosur &lt;Priya.Hosur@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++++<br>
&nbsp;1 file changed, 6 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.c<br>
index 6d3ed55e9ab4..9fcf15d69b7b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c<br>
@@ -375,6 +375,12 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_use=
rmode_queue *queue)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace=
_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_UNMAPPED);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue=
-&gt;state =3D AMDGPU_USERQ_STATE_UNMAPPED;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Heavy-we=
ight TLB flush after MES unmaps queue to ensure<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * in-fligh=
t memory accesses complete before memory is freed/migrated.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * MES does=
 not do this automatically unlike HWS.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_flush=
_gpu_tlb_pasid(adev, queue-&gt;vm-&gt;pasid, 2, true, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-- <br>
2.43.0<o:p></o:p></span></p>
</div>
</div>
</body>
</html>

--_000_IA0PR12MB8895E3ADC3692524015EDC2AF3D82IA0PR12MB8895namp_--
