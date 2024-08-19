Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CA0C3DA4A
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 09:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 742B710E230;
	Mon, 19 Aug 2024 09:29:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mJWws5Fo";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E0A610E230
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 09:29:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lH1rk/7nRv89dYFwm1zya2UIlLduXBSJlT6YCUaZ8Je0V3XKgNDMs6FqSduTunqoPW8TdAUPdTLeF6wAXCAGkHTFn8J91AxP4LZdSX6tZSyzMA9mawTCVJ1jk/WfwaFmMCRKkr9WZ746K+LIusZ42sceNVzYk5a072leKjqWB6f2C6M2xO5UxttvbIfXCeyLqH1Z0bF+oMuo/sUh4UkKnQp15C1DWs2Crgyu0MogRI58VPFFJGWwn9CiTHE5FwbpqsUoVErYlohsdoFj4iTS9r91eO+ot+CGpb0gsDAxlfeXkezBUHjrfhI9D9FzVbEPbiC289tTJhkjMvoBGsiKHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4RI5bRVObP56QrQ4iWwrdU3UimoAeUIjNvJg88Kbng=;
 b=pE50wTZQQMAqBvnV/YlcY0s6eLIZMcCi8LSA0ZOdmQMhynNF3OTBx1rRpPJJJBjdLWEXKrGS7f11OT00st6BRml0cGKhTX8j5NRPogOmJH8nAsKg0BPKVRkj3UrNNd1PPgLXBDD/IZvR/MugEJL0LpoTLGb7V0OgftjpJ6gzLZJkQVrE9Ew2p3LVPJUwrcqwIOiqIRLZs4OtWr0Y439AD78r/QAxPN1t3kdTF8OwIJs56qxAEUXmZ/Iy+iv27Pft6kNAUtGCT57puymqUki+DZLE3N7kxKq7blFbgqjpD/CkOkb6wzkou+Bl+5cQUxduZQdccXVCanOsP2JpXMBJug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4RI5bRVObP56QrQ4iWwrdU3UimoAeUIjNvJg88Kbng=;
 b=mJWws5FoPsnFD9EX8qs5oZwsyF5OojMh0pyHNUonAy127yNMlN41LnJvBVr1ZMlfb/XLdHefjvohktYMqMn0T3Nj+iNy7eF1gHinZcYeHw6Uz2NLIwXjZ1sNqz5Z02srit7QCqB23Z4ZCdZEY7glZZX4DZdw8S9xw+7LHan4EBE=
Received: from SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15)
 by CH3PR12MB8546.namprd12.prod.outlook.com (2603:10b6:610:15f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 09:29:00 +0000
Received: from SA1PR12MB7442.namprd12.prod.outlook.com
 ([fe80::cf37:527e:ce1c:5a78]) by SA1PR12MB7442.namprd12.prod.outlook.com
 ([fe80::cf37:527e:ce1c:5a78%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 09:29:00 +0000
From: "Huang, Trigger" <Trigger.Huang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Khatri, 
 Sunil" <Sunil.Khatri@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: Add gpu_coredump parameter
Thread-Topic: [PATCH 1/3] drm/amdgpu: Add gpu_coredump parameter
Thread-Index: AQHa7we2tU++i7Ut3EaBHHrGEVd6bbIoer0AgADp8wCAAIHBAIAEbTug
Date: Mon, 19 Aug 2024 09:29:00 +0000
Message-ID: <SA1PR12MB7442CF211A4956C3A7591BF9FE8C2@SA1PR12MB7442.namprd12.prod.outlook.com>
References: <20240815113836.399377-1-Trigger.Huang@amd.com>
 <20240815113836.399377-2-Trigger.Huang@amd.com>
 <CADnq5_NumwJ6ujpJERTF7gK7TAJMkG7MNMNgrtr3=k8pqYnBvg@mail.gmail.com>
 <SA1PR12MB74425F710D53EAA007A062F2FE812@SA1PR12MB7442.namprd12.prod.outlook.com>
 <CADnq5_Oy=-54C-m1UHJijEL+LdgRMJ_aGusuo2pjdcp6nCg5xg@mail.gmail.com>
In-Reply-To: <CADnq5_Oy=-54C-m1UHJijEL+LdgRMJ_aGusuo2pjdcp6nCg5xg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ed5ad6fe-bd0b-4186-b860-0dc0e32a7aaf;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-19T09:19:17Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7442:EE_|CH3PR12MB8546:EE_
x-ms-office365-filtering-correlation-id: 08e8efd5-c6db-40ab-8639-08dcc0315bd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZjQ0SWNxQll6Tzl6SCt4blhuUzhvRVN1V1cxeTNvOGRib2VDUndxbnhvMVNF?=
 =?utf-8?B?b241WXA3N1BWR1F4NmZieml6cFBvdFh0WWZtcFlmOUhVNk9jaXgvbHd6WFg0?=
 =?utf-8?B?WWY1dFhsQm56eGsxZWlvY3p6VHR3a0Y5RFFSc1V2eFBMbldqZXJQT1AyL2p2?=
 =?utf-8?B?U1padVUvUHpmU0Iwci9JaUEzcTJoa0t1d1RDRm1mVVVRd3k2b25uS0ovM2o1?=
 =?utf-8?B?cTBEYlJUcVYxRjNSM2VFL1ZFTWpNUXNVdEFMUTJ0bjZWVjJCbkJEU0d4cVRk?=
 =?utf-8?B?Ukl1TG9xczVURmdkc25KNVBpcDVEMXpkWlZYTnErcjVETThVKzdlNnhDdmVa?=
 =?utf-8?B?aVFlOUI3U3dxL2FSeGV3Nmx1S0M3T2tpcHEwa1VSR2lSaEg3QW4wODRabi9F?=
 =?utf-8?B?K1l3R2lkbXE4REdYMER4OVVXWGpjL00wOG1FOUdkNHV1dzd1dHVyYko0N0dv?=
 =?utf-8?B?UVNIaW5VZWQraXZqVVFnSUg4YTAyNzcyWHNqQ2VpZ0tOTzNjZDZWN3NEeUQy?=
 =?utf-8?B?ckdwMkhXbFFkQjZ2TXdsY2xteEc2RTNSeFQ1T1FnQitMbDM2dHRsS3FTcmto?=
 =?utf-8?B?YUQwZWtLQVZPSzA1L1VxdTRBckh4Rmk4aDAxRHdqek10ZEhVNHVWNzRubWx6?=
 =?utf-8?B?RXBGWWZ1a0swc1EvVWRKUTVGZWRMa0RUSU9DbXY3cUpPdG5qVjFIdXJYZXRt?=
 =?utf-8?B?VW04T1VyUldXamNmY1A1K21OaFh0L2pmS3FMYzF6MlNCNjBNM0duN2RzU2Rq?=
 =?utf-8?B?d1diZWdxa2ladGtmOVhsWG9DMnNRdlRyelBsTTdhcWFHWlUvMGYzMDdsNmQv?=
 =?utf-8?B?akR4NnRVMVllMjBYNCtJWEY3ekJjQ3pJYjRCdXgwQnovZ0NuOWNoYkw4K256?=
 =?utf-8?B?Ymgrb0NBYTJjYmZtL1czVXVJQUcrRU1pdzlzbTBRYWtTcStCUkJGQ0h4a0d2?=
 =?utf-8?B?VDZrMnJtckgvVFIxc1BSdFd2SFR4UXk5OUVHMGpMNDE1aTZOejBFNnlJeUFY?=
 =?utf-8?B?QnFBME1oOHRwRlZHcUpyYTZsWlVwWWNad2t2YXpzY1h0UU9TTzl5Ni9sSDFW?=
 =?utf-8?B?Z2dKNXVXb0FEdlJjMUxRWW55SHV2cm1kZVAwR3RjNGtBRHZqNTZMa3lrQ3Rw?=
 =?utf-8?B?Z3E0NTN3c2tJb2I4ek1JaTAycVBkMHFITWtlcWh2M2MyUTkwN2ZMb2xhbFhY?=
 =?utf-8?B?WXVoQTlZNERrR0w3cXNaTUpvcGtuTU5ydjJlZG1JUnVnYW52RU55SWptZGxW?=
 =?utf-8?B?ZjJVeVBUMStoSS9VLzE0L1FnK2NJTHJqVWJPRzhWd1c1ZUFXV0xlcE5odVRE?=
 =?utf-8?B?UHdZWm9QTVQ1V3hSMDhkd1BDZ0NHSlc2RE9SUUtZVlNWK2lyOGw3U2l6Nkdv?=
 =?utf-8?B?SzR5KzdPdnFveTZGaWZtMVZQWjZkU0pqUXZndUJtdnExbUJ5RDd1em5NWkZI?=
 =?utf-8?B?QzZRaEo5Qks0MDN2MVpVWnJhcGswV3BLeWNhV0lZa3NYNHVxaWp6YVRWa3Fw?=
 =?utf-8?B?Rk8xR0x3aHNZNjBMSDE3NkIveDNTQlhHclFCY2p4K0pUMFNhSXF5ZlB1Y3J6?=
 =?utf-8?B?a3NVN2M2VHJIQ0VzcWwwbms5ZzdrTTYyTlRSVStkbU50d1FjMUF6SU9CcTl2?=
 =?utf-8?B?L1EwWi91L0ZaU2Y2TEVnTGQyeS91eHdtRUJla0lac3U4UHFReTBYUmR4NXQ0?=
 =?utf-8?B?K2VNSXVrRUlRLzhlbk5TOWtwdzA1dDBha1dsRCs5eUJaK0c5M1VKelVYSVls?=
 =?utf-8?B?bHVVcTNrNEtMN0NMalFNaG0zRU8wbHIvZy8vMFR4dXpxcllqbHpCUXB4blcx?=
 =?utf-8?B?UjBNTk1BQ3FKTUFLTlo3TnluV2JMZDkzaW1ydXYzWXpTcHhUdDF2SEZBTVI0?=
 =?utf-8?B?Z1RJbytMaHRjQ2o3TnhrNHFWTzJ3cGU1Y0NIell0V0ZOY2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7442.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ampDMXIxV3J5WmU4OXZOK2QzWVBnRGZCNVo4WHhMSEZaMytpQlRzWTNxQkhG?=
 =?utf-8?B?RmlLK3Rkd29JaE9MRFVyM2J3NkxWNU5JamFkbU15MitHTTZVQzRPSDNwZHZX?=
 =?utf-8?B?Q1NhSk85TkxTbC9xUHI5dUtsUVMzZ0sxMCtFTkh1amsyYmY1ak9jTnpZWmFu?=
 =?utf-8?B?dmhvMEgwVmdkUWQ1MXUwTWQwREQ3eEJOelRKbEpIOG5BVTAvbHNnN1Zxa29G?=
 =?utf-8?B?eEFpMndyZUlENWprd0ZOTThPcms0bnl0UzFmQTNTQS9BZndNdDh0Q3NrUzEy?=
 =?utf-8?B?UTFCZXZQdHZSbVE4RkROU3hQT0U4SUdUeks1bDJhYXhiZTA4bDlyMXhaWlVs?=
 =?utf-8?B?cE1FYkpFTjVQeTZNRXBWc2o0QmdVWnR3aVpYQlhIbWpEb1lmYjdDR1R6QmF6?=
 =?utf-8?B?MVVKL0VzYWluRW5JZjZSV00rMTY5eStqQXZHeDRGRU5acFZIKy9NRWtsY2ox?=
 =?utf-8?B?eWFqUjhqb0ZSTDZEVEJOc2JNbmU2d21sQTRmTlhYQWtKa2ZOTVptUTdZdEZ2?=
 =?utf-8?B?NVNxbU5NRWhLRGdmOFFZamRwT1RMVXg5REVuVnc0R05TYjV3K3ZGbWJFU0dY?=
 =?utf-8?B?d01EZ3VER1I3c3dnUzdHOVB1bVF5RUgrZlBjN3ladFl0UllrWjZLV1U5cy9t?=
 =?utf-8?B?WFdITXFwQy9sTDFVdWhnRDZ2cTBrd3pOR2R2eXZyN01GNy90dzRZWm1mNkdY?=
 =?utf-8?B?VitXN0hHZndwZGJlVTBuTEpjU0xmT1U1K2hSR1BYNVFxOWQwdk56VklITjI2?=
 =?utf-8?B?bEZwUVh6MkhZQlBlNUJQeVcyOUZxYzkrcjQ3U3hCeCsrOFpCTWtlakI4a0VE?=
 =?utf-8?B?R1VwbTRhaVh4Y0EzanlTbml4ZUdJZmpQb29rK29IT1h0TzM3S0FDc04yTHR4?=
 =?utf-8?B?cmdvckNQeXVUOXIvNE5tQUFIQzdSUVBqbWhrR3BhU3ZNRmhKTTduK0lKNU5z?=
 =?utf-8?B?eUExZ0wwQXU2bVBVNEZhWERZRHN3UTVCVGx1WW9ZR0F4Q1k2ck5aN3Fnb2tL?=
 =?utf-8?B?cXE1Tmw1a0FSMWdTckt3enNGQVZsYzhMbFhQOVBwb2FYVURXZ3NKaGlDanJh?=
 =?utf-8?B?ZTNHYjhGeWFyczl4dTRCY0RmK0xFR0FiWHYyMHlpaWdyK2lFSUQvVFZwS0dC?=
 =?utf-8?B?RnV4b0prWC9aeDdSUHpCTFAzSGdHM3RLTStjSkQzOHZhZXlCVUF3eHg3TVM2?=
 =?utf-8?B?YlJlZWp0bllKR0VEaUU2cTRFTmlrSVJaTUxTTWsxbTZWLzA2eFpGWEFrWkdx?=
 =?utf-8?B?cHFPZVY2ZWdmbjBRRGphYSsxUDBvTGQ2b1FJbW1rSlZZdXpqWHprL09saGNy?=
 =?utf-8?B?dG15dVd5bTNtK0t3ZkJGOFhxRzNhSEFnZ2xBc2I5eWN3aTBBTUlEZWpQQ2Z3?=
 =?utf-8?B?R0xqQmFqV1p0QWdQYmRjQU0vL0huekRmRmRPWmdWTnM1RFlWUGozK3dlOXNu?=
 =?utf-8?B?K1RNOEVSZzhvb29iWU1Qb2QyeDJRTmRyNnZYM2EzeEtYekRjTmNNamZrWU93?=
 =?utf-8?B?aDQ2VkpmYWljLytnYzNNOVYzYjI2L1gyT0hteHdsTDBxWWRrT0s4ZjlKcWl2?=
 =?utf-8?B?NS9EUUpodEFXcEo0WHhBQ3p4VmNkMVkyR1pITXdIVXVwSmFSajU5eWlvWXZE?=
 =?utf-8?B?Vko5bFZaK2VUci9sK29jSnlpZkRlalVIbnFtVk5JQnVDL3RCclhKSmZweW1X?=
 =?utf-8?B?MWJPb1JRK1hBSlc5WUhLN0gybCsvYUhlNURZRndsTUtaSDJNTElFNFU2NFZs?=
 =?utf-8?B?dE1mSFliU0E4WHRyVGV0ZElMVlRMK2tveG9nZWEwNEl0RXZ4eEFHWFlUMUxy?=
 =?utf-8?B?ZEZVWGlZWG15NFpuekE5MFI4NGRlaVBxWEZ2MFRraFhTYm1DVEkzNDV2NjI4?=
 =?utf-8?B?bERvZTVIanlOTFcrS2xtQkVpdjZRbC9FWHhqdjd1YXN0SENkZUJKN0lUcERS?=
 =?utf-8?B?OXpHRjIxVGRJVVo5cVlKRU16Q05mZUxBMkF1RVlLN3luWEp0SkVyRm9aZWx4?=
 =?utf-8?B?TFlyZWR5a2hwd0k4dmlYNHg4NjdHSExOdFU3TUdzTzFiTHJSQWxsS0JHTllS?=
 =?utf-8?B?WjJSVlFoN2pGWGdwb0ZNcDZVTVpRU1BVTWxRcjAvQ2xNOUkzYVlRZGxHNng0?=
 =?utf-8?Q?kTxw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e8efd5-c6db-40ab-8639-08dcc0315bd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 09:29:00.6431 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 27NXl4Y+P0YBHmQvPImbnj45moSxa6TDASpIc0kv5TsdfRnzITwIcMyq3P7rIizu7cWJDno/84GMKmjARZpZBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8546
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4IERldWNoZXIgPGFs
ZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMTYsIDIwMjQgOTo0
MyBQTQ0KPiBUbzogSHVhbmcsIFRyaWdnZXIgPFRyaWdnZXIuSHVhbmdAYW1kLmNvbT4NCj4gQ2M6
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBLaGF0cmksIFN1bmlsIDxTdW5pbC5LaGF0
cmlAYW1kLmNvbT47DQo+IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIGRybS9hbWRncHU6IEFkZCBncHVfY29y
ZWR1bXAgcGFyYW1ldGVyDQo+DQo+IE9uIEZyaSwgQXVnIDE2LCAyMDI0IGF0IDI6MzbigK9BTSBI
dWFuZywgVHJpZ2dlciA8VHJpZ2dlci5IdWFuZ0BhbWQuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+
IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHld
DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBBbGV4
IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gPiA+IFNlbnQ6IEZyaWRheSwgQXVn
dXN0IDE2LCAyMDI0IDEyOjAyIEFNDQo+ID4gPiBUbzogSHVhbmcsIFRyaWdnZXIgPFRyaWdnZXIu
SHVhbmdAYW1kLmNvbT4NCj4gPiA+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsg
S2hhdHJpLCBTdW5pbA0KPiA+ID4gPFN1bmlsLktoYXRyaUBhbWQuY29tPjsgRGV1Y2hlciwgQWxl
eGFuZGVyDQo+ID4gPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gPiA+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggMS8zXSBkcm0vYW1kZ3B1OiBBZGQgZ3B1X2NvcmVkdW1wIHBhcmFtZXRlcg0K
PiA+ID4NCj4gPiA+IE9uIFRodSwgQXVnIDE1LCAyMDI0IGF0IDc6MznigK9BTSA8VHJpZ2dlci5I
dWFuZ0BhbWQuY29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gRnJvbTogVHJpZ2dlciBIdWFu
ZyA8VHJpZ2dlci5IdWFuZ0BhbWQuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBBZGQgbmV3IHNlcGFy
YXRlIHBhcmFtZXRlciB0byBjb250cm9sIEdQVSBjb3JlZHVtcCBwcm9jZWR1cmUuIFRoaXMNCj4g
PiA+ID4gY2FuIGJlIHVzZWQgdG8gZGVjb3VwbGUgdGhlIGNvcmVkdW1wIHByb2NlZHVyZSBmcm9t
IGdwdSByZWNvdmVyeQ0KPiA+ID4gPiBwcm9jZWR1cmUNCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVk
LW9mZi1ieTogVHJpZ2dlciBIdWFuZyA8VHJpZ2dlci5IdWFuZ0BhbWQuY29tPg0KPiA+ID4gPiAt
LS0NCj4gPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oICAgICB8IDEg
Kw0KPiA+ID4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwgOCAr
KysrKysrKw0KPiA+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCj4gPiA+
ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dS5oDQo+ID4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgNCj4gPiA+
ID4gaW5kZXggOTM3ZGUyMWE3MTQyLi40ZGQ0NjVhZDE0YWYgMTAwNjQ0DQo+ID4gPiA+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+ID4gPiA+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+ID4gPiA+IEBAIC0yMDEsNiArMjAxLDcg
QEAgZXh0ZXJuIHVpbnQgYW1kZ3B1X2ZvcmNlX2xvbmdfdHJhaW5pbmc7DQo+ID4gPiA+IGV4dGVy
biBpbnQgYW1kZ3B1X2xicHc7ICBleHRlcm4gaW50IGFtZGdwdV9jb21wdXRlX211bHRpcGlwZTsN
Cj4gPiA+ID4gZXh0ZXJuIGludCBhbWRncHVfZ3B1X3JlY292ZXJ5Ow0KPiA+ID4gPiArZXh0ZXJu
IGludCBhbWRncHVfZ3B1X2NvcmVkdW1wOw0KPiA+ID4gPiAgZXh0ZXJuIGludCBhbWRncHVfZW11
X21vZGU7DQo+ID4gPiA+ICBleHRlcm4gdWludCBhbWRncHVfc211X21lbW9yeV9wb29sX3NpemU7
ICBleHRlcm4gaW50DQo+ID4gPiA+IGFtZGdwdV9zbXVfcHB0YWJsZV9pZDsgZGlmZiAtLWdpdA0K
PiA+ID4gPiBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiA+ID4g
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiA+ID4gPiBpbmRl
eCBiOTUyOTk0OGYyYjIuLmM1ZDM1NzQyMDIzNiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiA+ID4gPiBAQCAtMTc4LDYgKzE3OCw3
IEBAIHVpbnQgYW1kZ3B1X2ZvcmNlX2xvbmdfdHJhaW5pbmc7ICBpbnQNCj4gPiA+IGFtZGdwdV9s
YnB3DQo+ID4gPiA+ID0gLTE7ICBpbnQgYW1kZ3B1X2NvbXB1dGVfbXVsdGlwaXBlID0gLTE7ICBp
bnQgYW1kZ3B1X2dwdV9yZWNvdmVyeQ0KPiA+ID4gPiA9IC0xOyAvKiBhdXRvICovDQo+ID4gPiA+
ICtpbnQgYW1kZ3B1X2dwdV9jb3JlZHVtcDsNCj4gPiA+ID4gIGludCBhbWRncHVfZW11X21vZGU7
DQo+ID4gPiA+ICB1aW50IGFtZGdwdV9zbXVfbWVtb3J5X3Bvb2xfc2l6ZTsgIGludCBhbWRncHVf
c211X3BwdGFibGVfaWQgPQ0KPiA+ID4gPiAtMTsgQEAgLTU1Niw2ICs1NTcsMTMgQEANCj4gbW9k
dWxlX3BhcmFtX25hbWVkKGNvbXB1dGVfbXVsdGlwaXBlLA0KPiA+ID4gPiBhbWRncHVfY29tcHV0
ZV9tdWx0aXBpcGUsIGludCwgMDQ0NCk7DQo+ID4gPiBNT0RVTEVfUEFSTV9ERVNDKGdwdV9yZWNv
dmVyeSwNCj4gPiA+ID4gIkVuYWJsZSBHUFUgcmVjb3ZlcnkgbWVjaGFuaXNtLCAoMSA9IGVuYWJs
ZSwgMCA9IGRpc2FibGUsIC0xID0NCj4gPiA+ID4gYXV0bykiKTsgIG1vZHVsZV9wYXJhbV9uYW1l
ZChncHVfcmVjb3ZlcnksIGFtZGdwdV9ncHVfcmVjb3ZlcnksDQo+ID4gPiA+IGludCwgMDQ0NCk7
DQo+ID4gPiA+DQo+ID4gPiA+ICsvKioNCj4gPiA+ID4gKyAqIERPQzogZ3B1X2NvcmVkdW1wIChp
bnQpDQo+ID4gPiA+ICsgKiBTZXQgdG8gZW5hYmxlIEdQVSBjb3JlZHVtcCBtZWNoYW5pc20gKDEg
PSBlbmFibGUsIDAgPSBkaXNhYmxlKS4NCj4gPiA+ID4gK1RoZSBkZWZhdWx0IGlzIDAgICovIE1P
RFVMRV9QQVJNX0RFU0MoZ3B1X2NvcmVkdW1wLCAiRW5hYmxlIEdQVQ0KPiA+ID4gPiArY29yZWR1
bXAgbWVjaGFuaXNtLCAoMSA9IGVuYWJsZSwgMCA9IGRpc2FibGUgKGRlZmF1bHQpKSIpOw0KPiA+
ID4gPiArbW9kdWxlX3BhcmFtX25hbWVkKGdwdV9jb3JlZHVtcCwgYW1kZ3B1X2dwdV9jb3JlZHVt
cCwgaW50LA0KPiA+ID4gMDQ0NCk7DQo+ID4gPg0KPiA+ID4gSSBkb24ndCB0aGluayB3ZSBuZWVk
IGEgc2VwYXJhdGUgcGFyYW1ldGVyIGZvciB0aGlzLCBhbHRob3VnaCBpZiB3ZQ0KPiA+ID4gZG8s
IHRoaXMgd291bGQgbmVlZCB0byBiZSBlbmFibGVkIGJ5IGRlZmF1bHQuICBJZiBpdCBuZWVkcyB0
byBiZQ0KPiA+ID4gZGVjb3VwbGVkIGZyb20gcmVzZXQsIHRoYXQncyBmaW5lLCBidXQgSSBkb24n
dCBzZWUgdGhlIG5lZWQgZm9yIGEgc2VwYXJhdGUNCj4ga25vYi4NCj4gPiA+DQo+ID4gPiBBbGV4
DQo+ID4NCj4gPiBIaSBBbGV4LA0KPiA+IEl0IGlzIGZpbmUgdG8gZW5hYmxlIGl0IGJ5IGRlZmF1
bHQNCj4gPiBUaGVyZSBhcmUgc2V2ZXJhbCBhcHBsaWNhdGlvbiBzY2VuYXJpb3MgdGhhdCBJIGNh
biB0aGluayBvZi4NCj4gPiAgICAgICAgIDEsIEN1c3RvbWVyIG1heSBuZWVkIHRvIGRvIHRoZSBj
b3JlIGR1bXAgd2l0aCBncHVfcmVjb3ZlcnkgZGlzYWJsZWQuDQo+IFRoaXMgY2FuIGJlIHVzZWQg
Zm9yIEdQVSBoYW5nIGRlYnVnDQo+ID4gICAgICAgICAyLCBDdXN0b21lciBtYXkgbmVlZCB0byBk
aXNhYmxlIHRoZSBjb3JlIGR1bXAgd2l0aCBncHVfcmVjb3ZlcnkNCj4gZW5hYmxlZC4gVGhpcyBj
YW4gYmUgdXNlZCBmb3IgcXVpY2sgR1BVIHJlY292ZXJ5LCBlc3BlY2lhbGx5IGZvciBzb21lDQo+
IGxpZ2h0d2VpZ2h0IGhhbmdzIHRoYXQgY2FuIGJlIHByb2Nlc3NlZCBieSBzb2Z0IHJlY292ZXJ5
IG9yIHBlciByaW5nIHJlc2V0Lg0KPiA+ICAgICAgICAgMywgQ3VzdG9tZXIgbWF5IG5lZWQgdG8g
ZW5hYmxlIHRoZSBjb3JlIGR1bXAgd2l0aCBncHVfcmVjb3ZlcnkNCj4gZW5hYmxlZC4gVGhpcyBj
YW4gYmUgdXNlZCBmb3IgR1BVIHJlY292ZXJ5IGJ1dCByZWNvcmQgdGhlIGNvcmUgZHVtcCBmb3IN
Cj4gZnVydGhlciBjaGVjayBpbiBzdHJlc3MgdGVzdCBvciBzeXN0ZW0gaGVhbHRoIGNoZWNrLg0K
PiA+IEl0IHNlZW1zIG5vdCBlYXN5IHRvIHN1cHBvcnQgYWxsIHRoZSBzY2VuYXJpb3MgYnkgb25s
eSB1c2luZw0KPiBhbWRncHVfZ3B1X2NvcmVkdW1wLCByaWdodD8NCj4NCj4gV2UgYWx3YXlzIHdh
bnQgZGV2Y29yZWR1bXAgZW5hYmxlZCBieSBkZWZhdWx0IGZvciBmdWxsIGFkYXB0ZXIgcmVzZXRz
LA0KPiBvdGhlcndpc2UgaXQga2luZCBvZiBkZWZlYXRzIHRoZSBwdXJwb3NlIG9mIHRoZSBmZWF0
dXJlLiAgRG8gd2Ugd2FudA0KPiBkZXZjb3JlZHVtcHMgZm9yIGNhc2VzIHdoZXJlIHdlIGNhbiBy
ZWNvdmVyIHZpYSBzb2Z0IHJlY292ZXJ5IG9yIHBlciBxdWV1ZQ0KPiByZXNldD8gIElmIHdlIG1h
aW5seSBjYXJlIGFib3V0IGZ1bGwgYWRhcHRlciByZXNldCB0aGVuIHdlIGNhbiBkbyBzb21ldGhp
bmcNCj4gbGlrZToNCj4NCj4gMS4gaW4gYW1kZ3B1X2pvYl90aW1lZG91dCgpLCB3ZSBjYW4gZG86
DQo+IGlmICghYW1kZ3B1X2dwdV9yZWNvdmVyeSkNCj4gICAgIGFtZGdwdV9kZXZfY29yZWR1bXAo
KQ0KPiBiZXR3ZWVuIHBlciByaW5nIHJlc2V0IGFuZCBmdWxsIGFkYXB0ZXIgcmVzZXQuICBUaGF0
IHdheSBpdCB3b24ndCBnZXQgY2FsbGVkIGZvcg0KPiBzb2Z0IHJlY292ZXJ5IG9yIHBlciBxdWV1
ZSByZXNldC4NCj4NCj4gMi4gbGVhdmUgdGhlIGN1cnJlbnQgZGV2X2NvcmVkdW1wIGNvZGUgaW4g
cGxhY2UgZm9yIHRoZSBjYXNlIHdoZW4gcmVjb3ZlcnkgaXMNCj4gZW5hYmxlZC4NCj4NCj4gSWYg
d2Ugd2FudCBpdCBmb3IgYm90aCBzb2Z0LXJlY292ZXJ5IGFuZCBxdWV1ZSByZXNldCBhbmQgZnVs
bCBhZGFwdGVyIHJlc2V0LA0KPiB0aGVuIHdlIGp1c3QganVzdCB1bmNvbmRpdGlvbmFsbHkgY2Fs
bCBpdCBpbiBhbWRncHVfam9iX3RpbWVkb3V0KCkuICBJZiB0aGUgZmluZXINCj4gZ3JhaW5lZCBy
ZXNldHMgZG9uJ3Qgd29yaywgd2UnbGwgZ2V0IHR3byBkdW1wcywgYnV0IEkgdGhpbmsgdGhhdCdz
IHByb2JhYmx5IG9rLg0KDQpPSywgdGhhdCBzb3VuZHMgcmVhc29uYWJsZS4gTGV0IG1lIGRyb3Ag
dGhlIG5ldyBwYXJhbWV0ZXIgaW4gdGhlIG5ldyBwYXRjaC4NCkFuZCBJIHRoaW5rIHdlIHdhbnQg
aXQgZm9yIGFsbChzb2Z0IHJlY292ZXJ5KyBxdWV1ZSByZXNldCsgZnVsbCBhZGFwdGVyIHJlc2V0
KSBpbiBqb2IgdGltZW91dCBzY2VuYXJpbyAsIGFuZCBteSBvbmx5IGNvbmNlcm4gaXMgdGhhdCB3
ZSBuZWVkIHRvIGRvIHRoZSBjb3JlZHVtcCBpbW1lZGlhdGVseSBhZnRlciBhIGpvYiB0aW1lb3V0
IHRvIGdldCBhIGNsb3NlciByZXByZXNlbnRhdGlvbiBvZiBHUFUncyBlcnJvciBzdGF0dXMuDQpG
b3Igb3RoZXIgY2FzZXMvc2NlbmFyaW9zLCBJIHdpbGwgbGVhdmUgdGhlIGN1cnJlbnQgbG9naWMg
dW5jaGFuZ2VkIGluIHRoZSBuZXcgcGF0Y2gNCg0KVGhhbmtzLA0KVHJpZ2dlcg0KPg0KPiBBbGV4
DQo+DQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+IFRyaWdnZXINCj4gPiA+DQo+ID4gPiA+ICsNCj4g
PiA+ID4gIC8qKg0KPiA+ID4gPiAgICogRE9DOiBlbXVfbW9kZSAoaW50KQ0KPiA+ID4gPiAgICog
U2V0IHZhbHVlIDEgdG8gZW5hYmxlIGVtdWxhdGlvbiBtb2RlLiBUaGlzIGlzIG9ubHkgbmVlZGVk
IHdoZW4NCj4gPiA+ID4gcnVubmluZw0KPiA+ID4gb24gYW4gZW11bGF0b3IuIFRoZSBkZWZhdWx0
IGlzIDAgKGRpc2FibGVkKS4NCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi4zNC4xDQo+ID4gPiA+DQo=
