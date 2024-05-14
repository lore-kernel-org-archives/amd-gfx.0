Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30117C04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 08:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52CC510E281;
	Tue, 14 May 2024 08:57:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2bdsjvJQ";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1659810E281
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 08:57:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JO+ylZiamHAI5RxKnMtrnJxkUGLt9mHOYgBqK78fD9Eol6MzSo8Flo7ZmsJfbgMk1sfnzYKH63eCCzPTWE5K9Kebju5Rx+A6aLg8ozFf1FRnZcTSgqBnkS1rtPKEQ4kBcyfHvw/OHDY80Lbdsd6Mzss99sQ61Z9nH9uCZ+bwg0aQEk6kbOduNXhR+pVkvrmW59y642HD/Glix85Wx4YqagqQDGeop9jGCDA4F8Psc4isofZhG90fUfn36RRoL0SO4AiWjY/fqvXqWoTf7TSxhQtNZLaxjHsS92pfCs58/bXGkm4hpwcp9ogig/MGjFRNYfs8Ib5woRLhdoukmucdeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIuseMvp5hjwJ8BhPLW9nWnE694xd27RtC9xkwJuPps=;
 b=C9b6aP/WaCa/WnVQ23AqhBpN70Id81oUoKjPIl8eIeeqn5Ouk+D6draYdYrKOMT3uo74QQty04aRuiIpqxhEzHQ5Q8yZ1tVa0brgtQAA0WIBME6PA69ThBPO1GLr5GBOPnqOkYOIw4E0Ab+PH0FeJdbm/vTazKtf98KS+GxozQSzOlPDveLkEtXqR1tIxReieKvx1Nru759bu94BF/IO5zF3CU2JwosNBxCywdKIycoD5LXJRlENeb0Mx/9FdZnVT7ke04OAYSA34Aht9uGScM1Ncboz/V0pCU5uHxGIVpzRfycU5ve/Ol2fPhtOqw16QUOwnbWzaxCB382i1fwQ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIuseMvp5hjwJ8BhPLW9nWnE694xd27RtC9xkwJuPps=;
 b=2bdsjvJQURS802+hsdMz9ARwXK3utqs0ew/cKYqgm19iLyW6eZlomjBfTdcj030rrPCAFMIQhBS2tPiBdEUXfrFHtJRUtBpR8dTDqoyURr8l4WDoa2YRvJoc4CKyJ2tB3sijR9AXLhYOBiKjV4FOnLRs82ZeOqyYhW2czN+FMjc=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:57:30 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::1ba2:8035:9950:d11b]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::1ba2:8035:9950:d11b%5]) with mapi id 15.20.7587.025; Tue, 14 May 2024
 08:57:30 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>
Subject: RE: [PATCH 2/2 v2] drm/amd/pm: check specific index for aldebaran
Thread-Topic: [PATCH 2/2 v2] drm/amd/pm: check specific index for aldebaran
Thread-Index: AQHapcwZKDzU7dKxY0K6PhXVFYkD67GWY0mAgAAKdXA=
Date: Tue, 14 May 2024 08:57:30 +0000
Message-ID: <DM4PR12MB5152348BB6A06B9AE8224169E3E32@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20240514065807.3651928-1-jesse.zhang@amd.com>
 <d318acf8-6378-476d-b9ca-a0c56621cecb@amd.com>
In-Reply-To: <d318acf8-6378-476d-b9ca-a0c56621cecb@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4a669179-5ca0-4c78-943d-d9cd39fd2de5;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-14T08:56:54Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|BL3PR12MB6402:EE_
x-ms-office365-filtering-correlation-id: 58b46f67-19b7-4a1d-5b40-08dc73f3e2f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?WFBPZW53NkIwbWFMakxQd3FmbG5jbCt4RDVtRm92N3lBeHo0UTI3ZysvVFJ5?=
 =?utf-8?B?NUV5Q2MwaDc5UjVkNC9XOWxzVHFUQzVPbVN0aE96SFJyYUVXWW56MDFvcEgw?=
 =?utf-8?B?R09sdmEyNFhGeUtsaXNHSzlaM0pkbUdxN2RicWhua3J3VGlkTlZMZFlSQVRH?=
 =?utf-8?B?QlRvUkk5bW1Wa25JOGMwcHBJNnF2ZzQxR1ZLb2tlck5hSG5GcmRnK01xdVBw?=
 =?utf-8?B?OFZMZmo3NFFmQXpBa0xoYU5xRElud0xpQUcvTnJzQkxyOFdZT3RRUUwvcWNJ?=
 =?utf-8?B?Zm9YbEVnRldHcDZEaTBSeUFVVVFYSjZ1eWV2Z3pvYzYwenhYNCtJVTAzT3hr?=
 =?utf-8?B?WnUwK0Q0alpNeVMzRTN6ZnZiamtSYVpRczFlT0lDaDJ4VUlwMGtkWkwxbXVS?=
 =?utf-8?B?NmdZNGEwZlRpTEk1WnhzZ1ZRdzljVDMwOWlaUldNaUtLL2RDamYxTXFjV1NK?=
 =?utf-8?B?MGpxVHdKV0c2dnVkbnphNUsrQ0o3SXdMaVIrcGNHWGxUU3pPbGRTZjE5bEJZ?=
 =?utf-8?B?dmRHTVg0OENJdUVLNjNzaXhocEdwaVEvNVpFRlkyaDB5SHMweE5JWGEvT0pF?=
 =?utf-8?B?NHhzYzRkTkFTdWtBa2swTzBXQ2lFYWJOTTZsZmtjazR5aG13OW9zd1pWZm9s?=
 =?utf-8?B?UlBHT3kzN0RkcEVOYzNmTTBBQ2tOQTIyWEhDL1lTVmQ4eDVZOVZRRlYwcHli?=
 =?utf-8?B?L2U2WUppamJGMys1dEZwOFFWajJWRlljZG00dHBpdmNLaERpS1dodmlDd3Ni?=
 =?utf-8?B?UkoyMTJHS3FlbXc1SEViSzVjQjBSM0FOK1hiVmhVSFNYa1Nwalo3eVEwdmFu?=
 =?utf-8?B?dDd1SjJSODhSMUxlVjJ0alNGTVA5bVFpZDZ6RFlMQWpiQ0xpRlREa0Mxem9L?=
 =?utf-8?B?andzSFQ1L0lrdzRUMXpEamVGVXk0dUx2eGdPLzdqdk93cWNHNmNISlk4emVr?=
 =?utf-8?B?M2h0K2tYeU1rQXhaeXdYcW8rK1NubDgwUHJxSy9JNm5sUHVJSUVUY09qT1JI?=
 =?utf-8?B?aDhaWG5rMkhqT25lWmF2UjFodUt5Q2RSSEpvV2lLbzY0aGsycVJITjVFS0t4?=
 =?utf-8?B?SWdqUHE4NDA4NXI4bFpncW1XQWVFc2U4NHdMYUZadUU3YnV4Q085V1RPNWJR?=
 =?utf-8?B?SkV4aW5XZFFHbktuN1lrMm5IY1Jhc25nMXJUcVhIWFZZNklzOVE4TTFLd3B0?=
 =?utf-8?B?OWIyNW13OERYeStiQU95Zm9ZVHovc0x0VjZ1c083dmVZWXk4Z0JFSDRuSTN3?=
 =?utf-8?B?VHFrZkt3R0RjcVFzMG9PbW5zRXFtV2ZSUDBGMHF3cWpqSU9reVJHQ3F3ZklY?=
 =?utf-8?B?NFdmbEtpZHBWZ0taK1QvTHBzZ0hPOVkyMDVodmNCSXNORE5aYkE4YmpmZFRu?=
 =?utf-8?B?UldsRXZpcitZanNXRDZRbDl0ZVRsSys4ZHFuREdaTG9VOTg4VVdFUGZUbVF5?=
 =?utf-8?B?VnlnWlZJWnI3QXprUDZlODNKeWJmOU12V09KNnBVOGd5ZzRWR0tTbFFsdXQw?=
 =?utf-8?B?Zjd2UC9IQTBBQUZNeGxEYzQrNjZYbjUvL25pekhoZTVGTWZ6UmZSN1RycXJS?=
 =?utf-8?B?ZmVEaDlqeHlTRlIxc3YyYzFPaE81MWYwUzlTWEswWFl3cTJXQzhkM1JIN0pI?=
 =?utf-8?B?NDRONmsyUTgxdXdVVnhFMGczQ1pKZHV4RVpQUE9RdDZ6eDFvMUV5VEpHTjFx?=
 =?utf-8?B?anlMZkhNWnBZQUNsd1RsQ2VITk4zbFJSeHlGTFE0UFJiVGJsZ3I2NFJCRFA5?=
 =?utf-8?B?VEpjeFlPZWJxcEFad2lUVE1KUlhmSlU0Ri83NUI4UGU5RFpSY1ZUbFFiS1ha?=
 =?utf-8?B?ZHU5WElpRnNBSXVFdEsxZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDYyc2ZUWFlKYysyR2UwMldjSzNkU1VNaDRxc1JGM2RxTUJobW1KelVTOHR0?=
 =?utf-8?B?a1R1ZTY2cDQ5ZVdUOGZMY3ZTSW5zUlhLY0NBNTRsSHZvNE96eVFmUThLTnhD?=
 =?utf-8?B?enNKaEVkSDFMYitZV0NRTVBCUzBDLzZhME1QbTFsNVFNSlpLYWl4dkpzclRs?=
 =?utf-8?B?Si8zTkdJM2tLbGZYdnRLNWJSWUtoeTZ5Ylo3MncxWHp2NGJhOXpmZVNudkVm?=
 =?utf-8?B?ZDQ0STdkTXRMS0pzRWVVTklOYjc5bGRpNmg5b2dWTlBNcVZpZHhPS2FSRG1C?=
 =?utf-8?B?dDdGdEZaY3JUeUVBYzlkcDhmVnR1Myt6WSt4c1ptMDNEVHpSVk1XRHhtRnBD?=
 =?utf-8?B?ajBNMW5tejRiSDNRWmoyWlBycmUrdElSdmEwV3BpeHRwOVBtazgvVDhjZVZE?=
 =?utf-8?B?WU8wM1d3NkFha08zK2FPZFhYaExlVGJSMHVrV0xDS2tqYmI2ZmhOamM2R2Jz?=
 =?utf-8?B?VWFjWFRBZ2RjczRITXZxZU82OS82cS81dHFibU9PaG54c2MzNVcxbmFPb25K?=
 =?utf-8?B?VEw0WnVFSFdOZU9Hdy80NERqMVhtaFM0S2gwaUxVM200MWJFOGJPODNPWmV5?=
 =?utf-8?B?VVVXUnlFN3R5d3NsOVpDYit0UGdGT2VSVXQ1OStDajkwcEJXZlN2TVY4bVBl?=
 =?utf-8?B?VW1mYTEyQ3JNSmNOakFCelA4U1ZmbTlJbGhXMUh4UTRDa2VzZmFIMVYvQXlx?=
 =?utf-8?B?UDc1UjdTWndJYUpKMFBJdUtuNFJGZWEzUmFUUVBBL3psbk5RVjNZVnB3cjVp?=
 =?utf-8?B?T25iR2RVcE9iZ1VPY0UyNW43SiswcVAvOHhvRThzemd0Vmx3VFR0UzI3bWhP?=
 =?utf-8?B?eHhzMWFXcG53c091N2svY05IbzdEY2lpZzdaOERSODhiYitjcmg0UXpSY3hO?=
 =?utf-8?B?SGVYWE9wYW9ROE1aUU05MGFoakVHUEFrcW80aGhRbnNXN3UzcmhDeHFhZm0w?=
 =?utf-8?B?aFJkYjlZdy9oTVMyVlJCLzdibFFMYUE2MUhkM3VRc1lkTTR4ZHNaek52Um5z?=
 =?utf-8?B?V2pqdnQ3c2ZOKzF0Z0RQcnc2dEQvQnVPQm5EYjRUNXpGOXQ5SlVlNHNqUUJV?=
 =?utf-8?B?Nmh5MFEyKzdOZExxT3VIdjF6blVtMDlLS09yemt0MGdIOUR2ZW5QdVpaU2Zk?=
 =?utf-8?B?MXBxMFJFWXZWNjdzQktHaWdKV2h3dmxvRStINWVtd1JmRFBvZ2h3MitLb25R?=
 =?utf-8?B?bFZVbTdPbFd5cXAwZHB1MU1yT1ZCWjdNYkV3UkM3Vm9ZOVp0SnlBUFNPOUs1?=
 =?utf-8?B?eWI0ZFVxUnFTcXNKdlJIeDhYWkhPVGtmUCtYMTlWV21leURma0Y4RDU1aXRa?=
 =?utf-8?B?dVQvNlZhLy9HRDlSTFZwN0lmcmtNM1JzZ3dFaGFHSjBnSUVlMEllOVhhYksx?=
 =?utf-8?B?K1J0d3MxZnRzNWt6Zm9VYmJZdEpicjRjRHpJaVR3dTA4QVl0bzYvWm1YMGtW?=
 =?utf-8?B?WkJVZVJudEZlaUVyaE9NLzFqbXFNK1JQNWlmQm1sQUJjaEg1WDBXRTRkL1hl?=
 =?utf-8?B?ZHF5ZzNDTG5IeEl4WHEwd3A5SnpzQjlIdWViYXF0MFdLbFNzMXdhaDA2RVhz?=
 =?utf-8?B?YmpIdU8xOHBGMmJPL1dZQkgySEdXSjZRcXRJcnoyQ1NQMnB4Sk9IbWdRbEdK?=
 =?utf-8?B?dzZqeVBtejBlVnEyZnIwYXlOanZwWTZweVN1SU15RnYwbFAvMnRYTlVsVlZi?=
 =?utf-8?B?RGh0OHIzYjl1dW1kcnJEU2l3RkRyUnkwUUVTSWY5WmVPSEZISmFGaFUxWjkv?=
 =?utf-8?B?TEV0TFNGRHBUY0RVY1U0eUUyc25QUmJHQlRPejRjNGY1K0xtcThoRkZqN2FM?=
 =?utf-8?B?R0E3bmdBTVdYYUwrbFJUdXpJMHQ3WXJwUkl4Q1Y0TTVkUXhXNXZ4RVl5VFJQ?=
 =?utf-8?B?V1FyNGpFSzNWZTJKcTg3OEduZTJjdVpNNXlubDZDOU9Md25FQ1FXMTlwWlFU?=
 =?utf-8?B?RG82eUpxbmFHRmdXT2JMZkYzRlVpdUo0REpLZ09DWnlCbVRDdDJPK3IzS3p5?=
 =?utf-8?B?MlFrZEE2ZksxTFBnLzMxbmtmbzM2dzBZZGZjcURsaE1EQ3FjblYxV1hYRkhy?=
 =?utf-8?B?Nmgzb1I4WmVnZ1RFNkJEa0ZjQzBodC9sM1F2S0ZZSEZWc0pneWlmaW4rb2VS?=
 =?utf-8?Q?C6BM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b46f67-19b7-4a1d-5b40-08dc73f3e2f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 08:57:30.0897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kt893GaiT4y/S3mII94YYrrLNDdzLUQx/7jFhArNozzNRduFKDPsVUEIqZWDuLuEh9tds2JKGVVd2pwchvd8Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402
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
Cg0KSGkgTGlqbw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGF6YXIsIExp
am8gPExpam8uTGF6YXJAYW1kLmNvbT4NClNlbnQ6IFR1ZXNkYXksIE1heSAxNCwgMjAyNCA0OjE5
IFBNDQpUbzogWmhhbmcsIEplc3NlKEppZSkgPEplc3NlLlpoYW5nQGFtZC5jb20+OyBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVy
LkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFt
ZC5jb20+OyBIdWFuZywgVGltIDxUaW0uSHVhbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFU
Q0ggMi8yIHYyXSBkcm0vYW1kL3BtOiBjaGVjayBzcGVjaWZpYyBpbmRleCBmb3IgYWxkZWJhcmFu
DQoNCg0KDQpPbiA1LzE0LzIwMjQgMTI6MjggUE0sIEplc3NlIFpoYW5nIHdyb3RlOg0KPiBUbyBh
dm9pZCB3YXJuaW5nIHByb2JsZW1zLCBkcm9wIGluZGV4IGFuZCB1c2UgUFBTTUNfTVNHX0dmeERy
aXZlclJlc2V0DQo+IGluc3RlYWQgb2YgaW5kZXggZm9yIGFsZGViYXJhbi4NCj4NCj4gU2lnbmVk
LW9mZi1ieTogSmVzc2UgWmhhbmcgPGplc3NlLnpoYW5nQGFtZC5jb20+DQo+IFN1Z2dlc3RlZC1i
eTogTGlqbyBMYXphciA8bGlqby5sYXphckBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvcG0vc3dzbXUvc211MTMvYWxkZWJhcmFuX3BwdC5jIHwgMTMgKysrKysrKy0tLS0t
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4N
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvYWxkZWJh
cmFuX3BwdC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9hbGRlYmFy
YW5fcHB0LmMNCj4gaW5kZXggYTIyZWI2YmJiMDVlLi5kNjcxMzE0YzQ2YzggMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvYWxkZWJhcmFuX3BwdC5jDQo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvYWxkZWJhcmFuX3BwdC5j
DQo+IEBAIC0xODgwLDE3ICsxODgwLDE4IEBAIHN0YXRpYyBpbnQgYWxkZWJhcmFuX21vZGUxX3Jl
c2V0KHN0cnVjdA0KPiBzbXVfY29udGV4dCAqc211KQ0KPg0KPiAgc3RhdGljIGludCBhbGRlYmFy
YW5fbW9kZTJfcmVzZXQoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpICB7DQo+IC0gICAgIGludCBy
ZXQgPSAwLCBpbmRleDsNCj4gKyAgICAgaW50IHJldCA9IDA7DQo+ICAgICAgIHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2ID0gc211LT5hZGV2Ow0KPiAgICAgICBpbnQgdGltZW91dCA9IDEwOw0K
Pg0KPiAtICAgICBpbmRleCA9IHNtdV9jbW5fdG9fYXNpY19zcGVjaWZpY19pbmRleChzbXUsIENN
TjJBU0lDX01BUFBJTkdfTVNHLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgU01VX01TR19HZnhEZXZpY2VEcml2ZXJSZXNldCk7DQo+IC0gICAgIGlmIChp
bmRleCA8IDAgKQ0KPiAtICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiAgICAgICBtdXRl
eF9sb2NrKCZzbXUtPm1lc3NhZ2VfbG9jayk7DQo+ICAgICAgIGlmIChzbXUtPnNtY19md192ZXJz
aW9uID49IDB4MDA0NDE0MDApIHsNCj4gLSAgICAgICAgICAgICByZXQgPSBzbXVfY21uX3NlbmRf
bXNnX3dpdGhvdXRfd2FpdGluZyhzbXUsICh1aW50MTZfdClpbmRleCwgU01VX1JFU0VUX01PREVf
Mik7DQoNCkZvciBjbGFyaXR5LCBvcmlnaW5hbCBjb21tZW50IGlzIC0gcmV0YWluIHRoaXMgYXMg
aXQgaXMsIG9ubHkgcmVwbGFjZSBpbmRleCB3aXRoIFBQU01DX01TR19HZnhEcml2ZXJSZXNldC4N
Cg0KQ2hhbmdpbmcgdGhpcyB0byBtc2dfd2l0aF9wYXJhbSgpIGJyZWFrcyB0aGUgcmVzZXQgc2Vx
dWVuY2UuDQoNCltaaGFuZywgSmVzc2UoSmllKV0gU29ycnksIEkgbWlzdW5kZXJzdG9vZCB5b3Us
IEkgd2lsbCB1cGRhdGUgdGhlIHBhdGNoIGFnYWluLg0KVGhhbmtzDQpKZXNzZQ0KDQpUaGFua3Ms
DQpMaWpvDQoNCj4gKyAgICAgICAgICAgICByZXQgPSBzbXVfY21uX3NlbmRfc21jX21zZ193aXRo
X3BhcmFtKHNtdSwgUFBTTUNfTVNHX0dmeERyaXZlclJlc2V0LA0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNNVV9SRVNFVF9N
T0RFXzIsIE5VTEwpOw0KPiArICAgICAgICAgICAgIGlmIChyZXQpIHsNCj4gKyAgICAgICAgICAg
ICAgICAgICAgIGRldl9lcnIoc211LT5hZGV2LT5kZXYsICJGYWlsZWQgdG8gbW9kZTIgcmVzZXQh
XG4iKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiArICAgICAgICAgICAg
IH0NCj4gICAgICAgICAgICAgICAvKiBUaGlzIGlzIHNpbWlsYXIgdG8gRkxSLCB3YWl0IHRpbGwg
bWF4IEZMUiB0aW1lb3V0ICovDQo+ICAgICAgICAgICAgICAgbXNsZWVwKDEwMCk7DQo+ICAgICAg
ICAgICAgICAgZGV2X2RiZyhzbXUtPmFkZXYtPmRldiwgInJlc3RvcmUgY29uZmlnIHNwYWNlLi4u
XG4iKTsNCg==
