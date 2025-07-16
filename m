Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AAAC83F27
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 02:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1CAC10E244;
	Wed, 16 Jul 2025 02:46:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OQJvodoH";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3938910E244
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 02:46:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKxF0YeskdbSLt19A/TYMqThgU2a5E+icnYWayFeB/KAxqIYABG6DHWpn/TArUnLh4oL804NR6Euk5u75bf1pTDaQPg+Ig379Ny3d9cCHBrjbxxpM47+phEcgIGWcMSEKKpwLaoO6SjPumFUcybuqoy1+EfFnJSynQSytq8enrahYy4BAtRQnRM15kqqK3SD1PtA3C9I3UY6dmlv+wbxdMfhTYAWykxCRDqJqWQaKIARtPRmhpoy4eKfh/XQKm0h3zPBOombuNQHfywnwySIPOoSlNqTiVupZtu3xZxk4qP/BQQMBvHfPabVfO7FSvT0uDq8pJ5wpQDVYA6+oOSNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQMMlMzKZwb8l5ivufqQBVQjaM2Er2pb/xQ3Ju6tkd4=;
 b=OxTz1o5OeqDBGKritsyQ535z1JEbcYBGK7OevOgpKIi00cyp/ZuCcLChbQOWHhw4IZvnHQ1LCiun1loXGTTTSIvx/XcyQOxS/QyJoTNHrEwhS+NgcYh5EVi0UA0k3zGBtLFp4zViQdx7gu8q8tsiq6/Js7n+TLG/GiSXW/bZ4gh2npRtRiZspA/oSpXVVBkK/W3vddN95Dxnyjbxqe4IvEqMVKFzv6oIUTzj2qAGWohX6+pQAy3Tr0xqSqfl4fL44cQuS8qDvyWC+Kca8H/jdrm/O0iHmkjwzvTnrbOLLVcC8+jK2a+7l2Hl2JE2ynUF8Aa4ReLpBAlNBI8mCXboqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQMMlMzKZwb8l5ivufqQBVQjaM2Er2pb/xQ3Ju6tkd4=;
 b=OQJvodoHX7URN1Y1LJHqMFILqEUDsHQYZMYttXgiBpk2IhQyFdXcmzOFQj8vn0egUTjQRHxZBKNFX1Z03jnTYsdUVgKm8K6JHrivolAgyk81y96CW4BrLgsDHgbWEfj/mh7FlmWWURtsiIr6UEMynhNm/xdzJcpxT6arliEYTHk=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 02:46:08 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%7]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 02:46:08 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Sundararaju, Sathishkumar"
 <Sathishkumar.Sundararaju@amd.com>
Subject: RE: [PATCH 10/33] drm/amdgpu/gfx9.4.3: re-emit unprocessed state on
 kcq reset
Thread-Topic: [PATCH 10/33] drm/amdgpu/gfx9.4.3: re-emit unprocessed state on
 kcq reset
Thread-Index: AQHb8rTfaORwkv0cTEKmVhDcuqDlQrQzYPkAgACxHsA=
Date: Wed, 16 Jul 2025 02:46:07 +0000
Message-ID: <DM4PR12MB5152C4441B34C04654DDF46FE356A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250711224024.410506-1-alexander.deucher@amd.com>
 <20250711224024.410506-11-alexander.deucher@amd.com>
 <CADnq5_P1syhswwZ8KOJkGeL=as4jDESOaxD2=jWn=zb-Dx9TxQ@mail.gmail.com>
In-Reply-To: <CADnq5_P1syhswwZ8KOJkGeL=as4jDESOaxD2=jWn=zb-Dx9TxQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-16T02:45:55.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|MN2PR12MB4111:EE_
x-ms-office365-filtering-correlation-id: 14a35079-18cb-4a94-995d-08ddc412ea83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?c1IwZHZkRmFORWlrZkVIZWpJRks4OXlBeXRXVGxEbS91NDhGT0xxdU5FR050?=
 =?utf-8?B?dE1UUVpoK0V1R0w3U1I2VHhaZE9RZkdyLzFzOVFYU3BMTjJEYlNVUVdWdDhN?=
 =?utf-8?B?NDZhcFJUWUF0NUxNNERIWHFiU3o0NGFpbXJCSTRjbTIxN1NXQlJlWHl2OGJF?=
 =?utf-8?B?UU5hVm9pZ0QrQy9UZEtSSUNsd2pNendaZVFMekU3bnZRNDNaaHZIT1hOSTNo?=
 =?utf-8?B?WldIaUdkUk1uUTIrR21lQVpGdmRNUkxuZHU0Q1FiYlh6aGlXSjBVRHNFVk5M?=
 =?utf-8?B?QmFQVE84QVZjOHU5YTRtQW9qSXZtbGEyT05VWHdUUS9FOEMvSG1NV1Rrd2o3?=
 =?utf-8?B?dG5xcENNODRCMjNjU3pPMkQ0THk0eWtEZDRmb1krOTBLTDZER2lpMjRqS0xi?=
 =?utf-8?B?ZjNzeWZOMG10MHZyVm96T0NDMnlvOTNOYnJvR2J5RWpDTWlVWGlmaVlEQ1ow?=
 =?utf-8?B?cGdNOU9vZ0RSTWpkOEwyNmtiVTd5U1Z2NFZPV242RGwrREpoRFhOUFQ2Umh1?=
 =?utf-8?B?cGJBeFhyZVplcUtxRGhsNFFUNC9hNFBEbEVhZjFscFJjSVgwZU9YbUlOV0Ew?=
 =?utf-8?B?emhFVlA4RnROY1YzMDRxVFRTblVsNGx2RURkMDdES0VRQWNmclZsd0RtU1NQ?=
 =?utf-8?B?b1lCNGR1amtGYUhVRG1RSlZJQThpVXhtWnBmTVdrWDRSbnp3eXZTUHhFM3pW?=
 =?utf-8?B?MHArZFczSm14WXNsb0RwRmh4M0FZZnhXWUd3cVlwb0VFWllXVWl5dUNhcHZN?=
 =?utf-8?B?YVRITFVFWlB2SUt1cDQ2NXdTTUdMQ2dIbFp5d1VwaExTS3VOMFRBSkpKUlFG?=
 =?utf-8?B?cmd3bTllN2VuQjVFSktkbGgzOERlaHBDSmpIYzFVMzJsSmxYMlRqV0pIQmFS?=
 =?utf-8?B?YjIyOUhDY0ZhZ25iOVZOcVkyYmhkUHFqSk4xZUZRMmVxTGpEMGQ5bFNMczh4?=
 =?utf-8?B?c29HUjFhTVA0ZGJiWXV4akRzYVBGZVhLR2JWeGVSN3NMT0h5dDZuOVVYQy9k?=
 =?utf-8?B?b1FHNGFpcjFWaWUxNE5jeGdndDNNNFkrdFA4WFZpOXZuYVNVTzJYdjhCVmFk?=
 =?utf-8?B?Y1VLRC9DUEVtaTRaUDFBV2dITnZDS2M3Uk81R2ZxRWU5U1o5NEhqZUdSdU1E?=
 =?utf-8?B?T0w1aEl0RmY2ZnZ6NENZaVRoVTVnV1RZT1JsMUFlY24rRGNab21XaXY0c0E2?=
 =?utf-8?B?VUZ4eXdNeTk5WUhIK2xlMzNNQk9WSWRaOElYZm1HTVM4Q0dFZlVjalkvNjIx?=
 =?utf-8?B?WHB1MTY0aGhMVGx6OTFXOUM0MnhmaldXd01keTY4MmVOV2JvSmcyVU1BemRq?=
 =?utf-8?B?Qis3b2ZEWTV2SkVIeHJVQWdPUCtrZDRzUEl3QnhmQmg0UThocWZwOFAvdUdD?=
 =?utf-8?B?eFhvZlpqUHpOWDRxNEtIaVI5ZXBscTVUcE5jMVVuVVNQRStZeGtoRU0rOGM4?=
 =?utf-8?B?OHdSZDIrRk1hSWtSZ0l3SVByRVBoWjdZN3pQWUJ4L1U3SjluMzNidS9xV0E3?=
 =?utf-8?B?RlBLYnc4bGZWKy9OeGRwQnQ0N0xveDB3Mk5oSjZNcUxJb1dIVkwwR0E2YzJy?=
 =?utf-8?B?cGxCK3ExZTYzV0Y5VnA4Rm1oL3NCdzFRdVZ3b2wvMnhFU3JDVWtBei96cDFi?=
 =?utf-8?B?dHZ3Rm9aRS90UlJFSysrWEh3bUJZQXdzOVE1TTQ1ODh3eVdod2M1K3ZLWVdm?=
 =?utf-8?B?ckQ5TXlndkZER0dha1dxb3FLSUpNM1RTQWRZOG9MSkhwWE1TNmhnTEFGci9Q?=
 =?utf-8?B?bHlWcjlNaHhKQjBpM1NwcWZhRmNCaWpKOUQ3UEJsOHRqb0xHMUFWQ2JnbFdo?=
 =?utf-8?B?K05oT21IRkhxSXk4Y0Voc2lXcGU2K1djL0RtMERxUCtMWHF4eHZncnNnQUVa?=
 =?utf-8?B?RkVNcGorQXNIOEt4bVZoa2tnV29ucEwvZERnYnVYQUJmY1d4L0JDM1IweGJF?=
 =?utf-8?B?RVVjbXNuaUN0ZzU0ZGE5aUZCZFh4T01GRVQwbHFqbk5ISnZTWXoxYlM0aitl?=
 =?utf-8?B?VTQrdkdYb0Z3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTRhczEwYUM5dE9mMlI3ejZjUzFkdEFSUU5BTEkwcXUwZjZpRkd2TlcrTzZ6?=
 =?utf-8?B?dTJ0cWJRYmlqZmhmcjNEQmZaejYrZm9ZdTVOSnRTNFcwVjg1YkE4b3Y4d0V2?=
 =?utf-8?B?KzNFN2Q1UE1kdnNobWoxVzFNcWpHQ2V5RjJYRGZ5QlBzYTBUcFVsYWxNT2RB?=
 =?utf-8?B?TEFnOGtHN3NZVDROaUM2bTk3NXI0OWtnNEJLekVmY0Y3UjI1SVBHelB3K1JC?=
 =?utf-8?B?WEtyZkY3WHNyVWFBa2J4djZJUGNUbXRuNnd6UHZ0V3pJVUJUZklKck9tY3dk?=
 =?utf-8?B?eWQ5K203QWs2UlMrb3F0aFNzanA5R3dPVkg0UGR4MEprYm04bnJnb09QNnlZ?=
 =?utf-8?B?eGxhMkxOVG5VcXJmKzgyaXV3eTVoUnBCNDdkcERqUk9KeTRDZzh1WGVVeUxs?=
 =?utf-8?B?TzJXNWRwRnlZS1doS1hyVDdod2RBa2p3ZitOaFRFd0lWOXhrQy9HaU5yTCth?=
 =?utf-8?B?U2s1eldZa3haQ0lGVnErcUtUQTFCRDYrTTlraEdsMUZ5Yml2NGxSVDVkZTR3?=
 =?utf-8?B?cWxsU3JIM05zL1c1YnJTUXdXNmE2bDgwOXFuY2g2WFdaamFYUWo4VGEyNnF1?=
 =?utf-8?B?ajFadFlhYWh6WDJScFU2MUlURzNHQTVRYURrWC9nY25WNWozaEVGb1I5TFpx?=
 =?utf-8?B?d2ZqVVBCa1VuNWtwUHJFMHpGcC9ETnBweXNLRjBRZy85eXdxVmd1c1YrdE4v?=
 =?utf-8?B?N3FGMVdIbnZOcWd0M2Q0cHdlaTJNdWRMT3JQSnJ6dWpQakRvcVVuYUlEMW4y?=
 =?utf-8?B?Ky9hRlp2RWdzaXd2aGc4WEE5SjdTY3hhMzVvL1VYSlpmL3BJUUlHRklWNldo?=
 =?utf-8?B?T3NERHp3NSs3SHBzRnJXaDVWcFh5S1JQN3NSVms5YnpINThUTlJueWZpbHZV?=
 =?utf-8?B?dGJtNjFGZDZ0Y0JBTDFBbllQLzZFcTl4T201Um96TjVjQ1dWQks4RzY3WFR1?=
 =?utf-8?B?SlFQbnQyYjNUeE1zdTFiQWhMTCt6WkczQnhsSWU3TVFkMEVpUGlEOEx4OEk2?=
 =?utf-8?B?YXJrdGtYUzk5L2VLT3ZkMHcvNzBCanFYL0NqZW9lQzlsWC9KR1ZOSUhpZVZs?=
 =?utf-8?B?T2ZKYmpNVjVHb0p0L1NyRXE4K3pZNmUrMTdkU0FNYVZHMExSaU01SmM2RGY0?=
 =?utf-8?B?bVNpTEZ4TzlsNlZqU1hxRUNzTXVoU0VUcXFyd3FzYnFXS2RuSDZLbzdaWXlo?=
 =?utf-8?B?cXlocFUyMnBRN1ptQy96Y0V1VzlNaWtNMUE5SDB1SVIvSktRSG1mUEpxb2M5?=
 =?utf-8?B?N2NhcDYrd3ZTMHlXRFFqUTdJZUpJRXhpR0xOdGtzUUFTRlg3VzV4NmJ0Rzk4?=
 =?utf-8?B?MCs2N20xcDVRWkROY2lUSDluVzMrVzcyVFladjdsbVJGUVhrNmVQd1h1WjdO?=
 =?utf-8?B?bHIwVjlidU95cEhwdnVhQmNvSm45QWpHNjQybHYvL2VKb2FoVS9LZWo4V0JK?=
 =?utf-8?B?TzRKUVNza2h4YjBBUEVERnhLV2cxZUxGWlVEKzVKTGxMdlpNenVDenFmNjNI?=
 =?utf-8?B?Mk4zc3RPRXpWS3Nla2xSQ0RmckVvbjVNRkt2TnJyMmV5MHlDZi80WjRZb2hT?=
 =?utf-8?B?UHRmeHZYUW5Gb25GL0hQT29sT3hna3ZaK3JYNGlueDJES3RvdnV5QUpoQlVj?=
 =?utf-8?B?akFGME5iWWo3MnlCcUxkTG9UQlE5V2NIYVBVcWQ3blJ4V1Bjdjk5S0w0WFlK?=
 =?utf-8?B?QS9rUys0WlRHNzR6M2xLN2ltSW9kdDRVeVUzcG1ySUNtWGs3d0tIUzJ1QTRa?=
 =?utf-8?B?elUveDUrd3lJbkRFWGtGWFJ3dWVPQ2hldUI1dkpTTVkxNGlWVWgvczN6WlVF?=
 =?utf-8?B?Q0VGYXVvRnRNREcrLzlOZlBkQTQrZHJvOE9EOHNBcTBna3hlNDhObE5lWWFi?=
 =?utf-8?B?dlB3ekljblpMemFuNjhZWlFvUlhqUVFlK1VWcWw3aWRXR3MyNHVscUdRVFB6?=
 =?utf-8?B?S3A1RmtHYkZ2b2RUYWsyUzZGaGU5WjB3YTBVdlJ3OUJ0c1JPajJGeUZrdVRO?=
 =?utf-8?B?SzdqRGQxS3dkTHhYa2dEMTFVUFpnRmFET2NyLzlaSER2QVJBZVAzT2VCb0tn?=
 =?utf-8?B?K0l1MitvVjlqeG1lbDRXdmE3RTdzenZadmVSbVZyb1FseVZUT1RJUjFHZlFE?=
 =?utf-8?Q?NWK0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a35079-18cb-4a94-995d-08ddc412ea83
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 02:46:07.9246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zWlELm44ArK96Tab5G+CST9nlozthWFjBqqLNl7ao5rJrZ3jKQj99N5S8KN5JgBQCSlTrdaA8EKeRBnpFzaQLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
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
Cg0KdGhpcyBwYXRjaCBpcyBSZXZpZXdlZC1ieTogSmVzc2UgWmhhbmcgPEplc3NlLlpoYW5nQGFt
ZC5jb20+DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQt
Z2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQWxleCBEZXVj
aGVyDQpTZW50OiBXZWRuZXNkYXksIEp1bHkgMTYsIDIwMjUgMTI6MTIgQU0NClRvOiBEZXVjaGVy
LCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmc7IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFt
ZC5jb20+OyBTdW5kYXJhcmFqdSwgU2F0aGlzaGt1bWFyIDxTYXRoaXNoa3VtYXIuU3VuZGFyYXJh
anVAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMTAvMzNdIGRybS9hbWRncHUvZ2Z4OS40
LjM6IHJlLWVtaXQgdW5wcm9jZXNzZWQgc3RhdGUgb24ga2NxIHJlc2V0DQoNClBpbmc/DQoNCkFs
ZXgNCg0KT24gRnJpLCBKdWwgMTEsIDIwMjUgYXQgNjo0OOKAr1BNIEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4gd3JvdGU6DQo+DQo+IFJlLWVtaXQgdGhlIHVucHJvY2Vz
c2VkIHN0YXRlIGFmdGVyIHJlc2V0dGluZyB0aGUgcXVldWUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfNF8zLmMgfCA5ICsrLS0tLS0tLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV80XzMuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV80XzMuYw0KPiBpbmRleCBlMmZmNGIzNzNhMzE5Li5k
ODBmMWZiMjYxZDFlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjlfNF8zLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzRf
My5jDQo+IEBAIC0zNTY5LDcgKzM1NjksNyBAQCBzdGF0aWMgaW50IGdmeF92OV80XzNfcmVzZXRf
a2NxKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywNCj4gICAgICAgICBpZiAoIWtpcS0+cG1mIHx8
ICFraXEtPnBtZi0+a2lxX3VubWFwX3F1ZXVlcykNCj4gICAgICAgICAgICAgICAgIHJldHVybiAt
RUlOVkFMOw0KPg0KPiAtICAgICAgIGRybV9zY2hlZF93cXVldWVfc3RvcCgmcmluZy0+c2NoZWQp
Ow0KPiArICAgICAgIGFtZGdwdV9yaW5nX3Jlc2V0X2hlbHBlcl9iZWdpbihyaW5nLCB0aW1lZG91
dF9mZW5jZSk7DQo+DQo+ICAgICAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJmtpcS0+cmluZ19sb2Nr
LCBmbGFncyk7DQo+DQo+IEBAIC0zNjI2LDEyICszNjI2LDcgQEAgc3RhdGljIGludCBnZnhfdjlf
NF8zX3Jlc2V0X2tjcShzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsDQo+ICAgICAgICAgICAgICAg
ICByZXR1cm4gcjsNCj4gICAgICAgICB9DQo+DQo+IC0gICAgICAgciA9IGFtZGdwdV9yaW5nX3Rl
c3RfcmluZyhyaW5nKTsNCj4gLSAgICAgICBpZiAocikNCj4gLSAgICAgICAgICAgICAgIHJldHVy
biByOw0KPiAtICAgICAgIGFtZGdwdV9mZW5jZV9kcml2ZXJfZm9yY2VfY29tcGxldGlvbihyaW5n
KTsNCj4gLSAgICAgICBkcm1fc2NoZWRfd3F1ZXVlX3N0YXJ0KCZyaW5nLT5zY2hlZCk7DQo+IC0g
ICAgICAgcmV0dXJuIDA7DQo+ICsgICAgICAgcmV0dXJuIGFtZGdwdV9yaW5nX3Jlc2V0X2hlbHBl
cl9lbmQocmluZywgdGltZWRvdXRfZmVuY2UpOw0KPiAgfQ0KPg0KPiAgZW51bSBhbWRncHVfZ2Z4
X2NwX3Jhc19tZW1faWQgew0KPiAtLQ0KPiAyLjUwLjANCj4NCg==
