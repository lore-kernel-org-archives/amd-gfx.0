Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B43C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 06:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 594A110E5D3;
	Mon, 28 Mar 2022 06:58:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7643410E5DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 06:58:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDQpf5uYOePaOlgHaXXEnhJV4K6UFI8iE+dxKNGYyKwo03pFJi6LyKpRepEDEpaYIkZbNMyOPcMpNztu2zpOXXRIzPe4LnAeWG9Eg6QaEa68hYtDsY8DL0CgxwMLrNey59/97cOfbAKUKQMaIaWsX2aoLeif4O+eHaetsof4FNQj5BrYTDwTXSR5dTJTAcwPft6SsYfzWO+534ObuL12TgV/NoHWT4gM1IoofKgJx94wupJDmdEAl/AFSjsZ37op9gpHsfL8tkhddeM8eP6WEcgyN1vdEALRrR/y0HeCWj05UHaoJjlghVRa5mIt8A8+q9TxGH/18WvirGLYCitrTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnynWH980zNo6HMp9oe0Gt86MAgvoahgaQKrh2VZb2Y=;
 b=i0DvZwTTDEalnN7y5534Wyy1hqP8EnPZD91UTlAD41v54gkernoS8VK0MgvFnCb2mFCfw4uiqYl4Mi+3LOszjly1t1ouxQU9E9W2s+EtRIUp703ME50Z4o4tZcJJLwgCL4RkL6ESY7i2r/SjuXPICkU0a7yXq469JruCEEhX0fEMPgudRUpxdmiImhcQAlC0C7avvjhhDQJKVgcicYmXplZg2/I/fmwJVA72IOPtEy3Vk9KFqZC526v0whDhsDLKDeDALAb9/YvnN0ywU9nmyKDufrd4/rNmX5lEbE/21oUv31ATRC3jtkx4fq03t0nOC7Z2gU/nU3u8WHKWHWznVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnynWH980zNo6HMp9oe0Gt86MAgvoahgaQKrh2VZb2Y=;
 b=0UO6XhFiEhTw7hbB929yapI5DVlOEdchqoNpY4hquT3MHy5Qcdq5GaPc3E2MLmDjmZG3VPRCEBFh/e/r4sOxD6VGF3AXKGeK1mlv1axS7SDBTjmq2hFYBsGq3SiYOtOzB/VlHbuvEW/A3BU4VddHrSoVGo1MC6yXNwi+Npbftvw=
Received: from PH0PR12MB5451.namprd12.prod.outlook.com (2603:10b6:510:ee::20)
 by CH0PR12MB5315.namprd12.prod.outlook.com (2603:10b6:610:d6::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 06:58:28 +0000
Received: from PH0PR12MB5451.namprd12.prod.outlook.com
 ([fe80::9cf6:6683:b92b:ae42]) by PH0PR12MB5451.namprd12.prod.outlook.com
 ([fe80::9cf6:6683:b92b:ae42%7]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 06:58:28 +0000
From: "Ziya, Mohammad zafar" <Mohammadzafar.Ziya@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH v4 0/6] VCN and JPEG RAS poison detection
Thread-Topic: [PATCH v4 0/6] VCN and JPEG RAS poison detection
Thread-Index: AQHYQmyVXPGIDfawWUi49KbPqZP1GazUWEkAgAACiFA=
Date: Mon, 28 Mar 2022 06:58:27 +0000
Message-ID: <PH0PR12MB54519A65963A95706FC3A2D5981D9@PH0PR12MB5451.namprd12.prod.outlook.com>
References: <20220328062453.4156191-1-Mohammadzafar.ziya@amd.com>
 <c79c62f0-ec5f-4b5b-731c-96eb50dc7197@molgen.mpg.de>
In-Reply-To: <c79c62f0-ec5f-4b5b-731c-96eb50dc7197@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-28T06:58:21Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1c4c4a18-ede4-43fc-a7cd-774857f4f7f2;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-28T06:58:21Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: d35ffd77-2103-4fba-a329-064f34e99747
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9015a05b-ddbf-4c84-3051-08da10885c92
x-ms-traffictypediagnostic: CH0PR12MB5315:EE_
x-microsoft-antispam-prvs: <CH0PR12MB531506B1A7974926C1787FE4981D9@CH0PR12MB5315.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y74h9ozVVNi9pfx1hSTHndk0DcjuBN5yR1+vXbxuK4r2ejJK+kdRo6aqMr3L3XMnke3bS9J1on4IsXNtoC3Wao722jobD9+k6SD8Ye9WCNxc7aCESRT47vtfiGgYCikS45drwVuA/0EBoWrqY3YF1CGOM9ctkIH5rkE07aYWSQ0hhcW1D0s1zCLOIQiKRJ/SI4BQOTG5G9vWXY9bM7eTE4MRnyjZ/SqI4vWPFpK9Od+CyCoowQDSz+uU5CO28SixZVCR54O8uVBS2C2m8xuyyI0g4DKXZ8cnOhZkEJdJSi9YCC0szWojvA2pBAD+QIvKDDgCrw3HqEVu/wEdpk+dcCYCaQXFEWk13DGAsvfxCQusI745c1uZpwcNwDCNkY6TEGzIoVqp/vCqvskssCEzds31MAptNGekJ3Xa8gsd26YohhsIJCNbNSTju1u1EokUn/2413wS/HKTLwdyHG7THmCx4KwKI1cM6pDOc3EIATuSQo1rEd6yYIxH+cKl9M/22a6BWqZyw6AS6yIL0XCUBdZuTcgcphfG0w9uapWzAxv5on6BCV81te6Ro1MvRvc3IHM3P4YSxATkGcgxeflWYBAeYNqqyeIsB6aJhZo6Aey5BjymNnc003i5fXPdS3NH1nkqf/F5FKDJ+DH4N/QX7AiF45i7B2FlzykB8/M9athU7VKGYTZ4MrWVeelKi9TsukCOGPPHnWLY5rZSfnC2kQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5451.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(55236004)(71200400001)(7696005)(9686003)(33656002)(316002)(6506007)(186003)(8936002)(38100700002)(4326008)(52536014)(6916009)(26005)(66556008)(54906003)(5660300002)(2906002)(38070700005)(66946007)(66446008)(66476007)(8676002)(86362001)(64756008)(508600001)(55016003)(76116006)(83380400001)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2FzOGZsWXRZSks1N25nT3NvU0l0Q2FzdXFqM2swWXgwSW9kVzhjZ0NNZmcv?=
 =?utf-8?B?QWtFbUorTExEVWVUQnNFL01oS29vTXBFaEVMR2lyVFVnRFE1MFdmQ1RORjhV?=
 =?utf-8?B?dzJoclduUSswcjdRR2JuTWc3L1pMTHZjUUdTeFBjOC9zMDE5MXlIVFM5am1H?=
 =?utf-8?B?QlBJMkNTUlhoQkRuTkNPZm1DNktkQVhFY1dwdVBYa1AwS2c5d1FBc3pkWVpZ?=
 =?utf-8?B?blRSVWVzMHR5bE93WjF2UXZ1LzhqN28zMHlLejNDUDBPcFRadWhxd2EzaXpF?=
 =?utf-8?B?RnlxaUNtZlNUVGdaYjVVRnJOQzJ2MGhhMitRU1NtVkI3dXE0WGYxUFUzK1Rv?=
 =?utf-8?B?eW9UT3VndTRPRWdiTnBvNzdxQVU4cUk5cnZNcTQ5d3N1cTZNSVl6UkZRdlY2?=
 =?utf-8?B?ai9EK0wwZER2eCtZYXZINnZTMWIxcEdoY3hoUXIyK1dpcnBxRUtHNElWWGJJ?=
 =?utf-8?B?aTZRN09WOHBTMkpVcTdlVERjRm1COWhVQS9yZytieVUxMURMbEttTnZ2d0hv?=
 =?utf-8?B?d0FvQkZPVmxLcTVYWm1PUWRHZ1VxdURUUUdmRUMzK3c3a2hLMjNnK3pPL2kv?=
 =?utf-8?B?U2xZNDhPOFhMaDNmRitXbXZYS3lmdnorVkMwWmJVYmZ1U2VRamZvc3cxMjgr?=
 =?utf-8?B?TWhPdVU5OThxeWZjYjNqZUNyc0N3eDY1WlUvYzRrVHgyTDdWVExTRjNhNmt4?=
 =?utf-8?B?UUNPM1MrNzE5ZE9NQUJVSUlCcWU0NjZDVUhvUmQ2TUxoWE1XbnZrOWtqSitU?=
 =?utf-8?B?bDhkMGdrK29XV2tGQUNpSDZxVERQVGt1WWk4TjlOVGxaVzFxYitmRG1xbzEw?=
 =?utf-8?B?ZzZ3SGlhWlNXemxmZU1tdklTQ0E4K0V1dlMzVlVwOGNyaFRsa1VGdTFjV0Zz?=
 =?utf-8?B?bmczM0tEa0d0Z2dUd2oyNGJWL2FjWGlCNjIwWFMvQUM5WkZxWGttNEVVc3Qy?=
 =?utf-8?B?K0hqcVQ1bFVFazR3anQ3dXNvT3dOSXhnWURTaitHYkpqNk1PWGRyTWRkbHcr?=
 =?utf-8?B?a2R5c0J5WFV0U0xIc2wzTE9uMU1nM29DajcyNUFITmljUytxV0JGRW5Tbnl5?=
 =?utf-8?B?QWRjYnZ6VEhYQUxzSjc4aW5CZG9uUGs3ZVdlZDI2OFNxWlEwT21wUnNsbitG?=
 =?utf-8?B?UVFnTXAvMCtlY05mUE9BWmdlUWVGUU9uUG1FSmNiYUxHY1JHdjRxRlQ3eWV6?=
 =?utf-8?B?Q1VMZExndkNQU2RoOWhBWUUrMlQyak9Mc2h0OWJkZWlSTXRyRklvRlU0dGtw?=
 =?utf-8?B?eW1QNnJHOU5MNFpBL2I4R1BZN293UHdTWTVHMnZaVnFNUU5HUi9YcFB2SUt6?=
 =?utf-8?B?akFtdWpVeG1pM1hsNmJlUnowcXRScWRiWDVpWUpUMHVTNzh6eWNnNVo0Y1Bo?=
 =?utf-8?B?dGszZWI1Ykx5Q2hYaEdnc1hwTXJpTVV6NnBOcklKTUxSYnRKQ3lwK2M4cXdi?=
 =?utf-8?B?cHlOcEI5Wm5BQkVJd2FtREVTeFhORzIvRUQ3QUtGdS96Qm4yWnZ4VkRmWjNZ?=
 =?utf-8?B?ei9ZV1ZZazNRRlZ6NWJnVDZUc01xSVhLU3ZaKzR3LzliSjl2bVZGMmFWYXRQ?=
 =?utf-8?B?TkZNdnBITm5KdmU5clpQK2VCNjFISXdrcGtOekYxcFRTNTVtQXVDUlZsK1p1?=
 =?utf-8?B?dnZQOVM3R1QvR21FdHgwUlVQMURtNE80TTJEbjRlSWt5THFSa1VZWGszYWFq?=
 =?utf-8?B?aTVCTkFGTFZCYjBjZGhoMHhKZDg4cWc4WjQzc3I5eUFjNm56MzdhcGNQNWIx?=
 =?utf-8?B?ejBDaGt4eEwxSGpCNWZ1M2k2SEpLVmw0WW5CcUgrSFVTUjRXekNkaDJuaDJ4?=
 =?utf-8?B?U1ZqY3Q2T2FudDFFd1k0SDVGd2twUUlVVzcvNk5lSEhRcHRJVEFobE1rUVEw?=
 =?utf-8?B?enBMUU8xWWpzK25MemhCa1pJMGRnS1ZOMjhtQ2FtMUdERjlXWXFyZ3E4V1ho?=
 =?utf-8?B?dHhnVERHVjhJU3hjZjE4dW5idTlGMTVROVZaY0w2VGYwWUNxZWVVbTdGMXJY?=
 =?utf-8?B?c1IxcGRLUFdoWXdsOXJvYjg3Z0t1SEFlSUpOYWJIK29RZ0lQVmdjUThVQnZq?=
 =?utf-8?B?bktiS29zVTJYdWF5NVZ3YTBGOWNDSWtnYlAyeENCVnlqMU03MWRDNVE2cGtH?=
 =?utf-8?B?L2RobTlGdVNLbW5XUlF3bXczU0dOa20yYWdIUUVoazRZTkJjVlAzdzlXNFlD?=
 =?utf-8?B?c3NWSC9INzZINlhSOGt3UE9UM2NObi90VFp0aEowOE9sY2FvSXJCU05jdk5v?=
 =?utf-8?B?ZDB4ZUo3N3k0RFBxV2g5c0N0WnFHKzl5RjZPNTVYTlV4WnVhY1krQ3BJRktQ?=
 =?utf-8?Q?B6CLZtjzt3jGb/YeUJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5451.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9015a05b-ddbf-4c84-3051-08da10885c92
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 06:58:27.9465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axZxRzCnxs1Pc+BzICPP8i00XpZthvLELd6t0PSSyP7i9wIK9La8/Cnvm2Y2TEFD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5315
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KRGVhciBQYXVsLA0KDQpUaGFuayBmb3IgcmV2aWV3
LiANCkFkZGVkIGNvbW1lbnQgaW5saW5lLg0KDQpSZWdhcmRzLA0KTW9oYW1tYWQNCg0KPi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogUGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2Vu
Lm1wZy5kZT4NCj5TZW50OiBNb25kYXksIE1hcmNoIDI4LCAyMDIyIDEyOjA5IFBNDQo+VG86IFpp
eWEsIE1vaGFtbWFkIHphZmFyIDxNb2hhbW1hZHphZmFyLlppeWFAYW1kLmNvbT4NCj5DYzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29t
PjsNCj5MYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcNCj48
SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMC82XSBWQ04g
YW5kIEpQRUcgUkFTIHBvaXNvbiBkZXRlY3Rpb24NCj4NCj5EZWFyIE1haG9tbWFkLA0KPg0KPg0K
PkFtIDI4LjAzLjIyIHVtIDA4OjI0IHNjaHJpZWIgTW9oYW1tYWQgWmFmYXIgWml5YToNCj4+IFZD
TiBhbmQgSlBFRyBSQVMgcG9pc29uIGRldGVjdGlvbg0KPg0KPkl04oCZZCBiZSBncmVhdCBpZiB5
b3UgZXh0ZW5kZWQgdGhpcyBhIGxpdHRsZSBiaXQuIEVzcGVjaWFsbHksIGhvdyBpdCBjYW4gYmUg
dGVzdGVkLg0KDQpbTW9oYW1tYWRdOiBUaGlzIGlzIHRoZSBmaXJzdCBzZXJpZXMgb2YgdGhlIFJB
UyBwb2lzb24gY29uc3VtcHRpb24gZGV0ZWN0aW9uIHN1cHBvcnQsIHdoZXJlIHRoaXMgc2VyaWVz
IG9ubHkgZGV0ZWN0cyB0aGUgcG9pc29uIGNvbnN1bXB0aW9uLiBUaGUgSW50ZXJydXB0IGZyb20g
VkNOL0pQRUcgYmxvY2sgd2lsbCBiZSBpbnRlcmNlcHRlZCBhbmQgY2hlY2sgdGhlIHBvaXNvbiBj
b25zdW1lZCBieSBWQ04vSlBFRyBhbmQgY3Jvc3MgY2hlY2sgaXQgaXMgaW5kZWVkIHRoZSB2Y24v
anBlZyBwb2lzb24gY29uc3VtcHRpb24gaW50ZXJydXB0Lg0KDQo+DQo+PiBNb2hhbW1hZCBaYWZh
ciBaaXlhICg2KToNCj4+ICAgIGRybS9hbWRncHU6IEFkZCB2Y24gYW5kIGpwZWcgcmFzIHN1cHBv
cnQgZmxhZw0KPj4gICAgZHJtL2FtZGdwdS92Y246IEFkZCB2Y24gcmFzIHN1cHBvcnQNCj4+ICAg
IGRybS9hbWRncHUvanBlZzogQWRkIGpwZWcgYmxvY2sgcmFzIHN1cHBvcnQNCj4+ICAgIGRybS9h
bWRncHUvdmNuOiB2Y24gYW5kIGpwZWcgdmVyIDIuNiByYXMgcmVnaXN0ZXIgZGVmaW5pdGlvbg0K
Pj4gICAgZHJtL2FtZGdwdS92Y246IFZDTiByYXMgZXJyb3IgcXVlcnkgc3VwcG9ydA0KPj4gICAg
ZHJtL2FtZGdwdS9qcGVnOiBqcGVnIHJhcyBlcnJvciBxdWVyeSBzdXBwb3J0DQo+DQo+SXTigJlk
IGJlIGdyZWF0IGlmIHlvdSBtYWRlIHRoZSBsYXN0IHRocmVlIGNvbW1pdCBtZXNzYWdlIHN1bW1h
cmllcyBhbHNvDQo+c3RhdGVtZW50cyAoYnkgYWRkaW5nIGEgdmVyYiBpbiBpbXBlcmF0aXZlIG1v
b2QpLg0KDQpbTW9oYW1tYWRdOiBUaGUgMm5kIGxhc3QgYW5kIGxhc3QgY29tbWl0IG9ubHkgZmFj
aWxpdGF0ZSB0aGUgZnVuY3Rpb25hbGl0eSBvZiB0aGUgcG9pc29uIGNvbnN1bXB0aW9uIGRldGVj
dGlvbiBvZiB0aGUgdmNuL2pwZWcgYmxvY2suIFRoaXMgd2lsbCBiZSBjYWxsZWQgdW5kZXIgSUgv
QkggdG8gY2hlY2sgaW5kZWVkIGludGVycnVwdCBmcm9tIFZDTi9KUEVHIHBvaXNvbiBjb25zdW1w
dGlvbi4gDQpUaGUgM3JkIGxhc3QgY29tbWl0cyBvbmx5IGFkZCB0aGUgcmVnaXN0ZXIgZGVmaW5p
dGlvbiBuZWVkZWQgdG8gZmFjaWxpdGF0ZSB0aGUgZnVuY3Rpb25hbGl0eS4NCg0KPg0KPg0KPktp
bmQgcmVnYXJkcywNCj4NCj5QYXVsDQo=
