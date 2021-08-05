Return-Path: <SRS0=ROs4=M4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67678C4338F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 09:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 281A261029
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 09:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 281A261029
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD3356E448;
	Thu,  5 Aug 2021 09:18:51 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2086.outbound.protection.outlook.com [40.107.101.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A47EE6E448
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Aug 2021 09:18:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTAeNzgBMgjinHOH7esQF+spDdtHZQ5K3q9aUyrETbaeST0hvf5sHVhT/R8psCL0POwC8/3lLQFdznOjG4OJcehNShpAbUSZ8Ki1k/kSWiecifNWFTDV9DxxXNdk7DAJwBaxtdf1kT+LN0R1Yl2pOHxA22EIqnv1wa3/IojbvJd8hopUDk8INUIjMiEOUyhjh9hNDEtH9pP3dpvmKOqN6o6iBq0K8URl7q+khQPbjEO6XzR8JzmvUtC+OwyTRkZlcyL7j0NsiNFYipc153jfqaDQuB6IF7jcMK0c4YgWL6asogQ0Y5hzb0rvAx4zuJBRKtQs+IdF9pQabv0EQV7Y2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekNoIRU/jZ2oIqH/mEi71+hGU7jvIYVtGapMIls09aE=;
 b=aUoR3LHTjAWxD7xmVQG0hubJ/37kuAiFw92AbD0++6U9oA5RGeaK+Jg1lxJtl44JX5xCsNzbo2EUZHi/JdHHvlR4mB7pvoPD/LUcCYrB95z201WM1l2rOjBlYjfTFFQfDbnFt0IrUEHy42CsgT6hQjTjnMX2sUi2CFoyS+vAL9zim2MF3Mfi0vqtMAeoA36T6xeI1E77X3N9/VMzVgzfpYPCvRORrcMfcPqXPBCx+F6q9/lz9R/fdIHjjsTZi2EL6uHA+7d2pH6yVSoCDVv694CE7FXy9qxmdZMprm4S9NCDMS9dQhFURtrupd7Qca5PhmYUf7frZEkw+mTSmzxogg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekNoIRU/jZ2oIqH/mEi71+hGU7jvIYVtGapMIls09aE=;
 b=S/+XNn+ilPRmj827F6y0PKy/8RjWbKo7Qe+DmBV6NLn+qBNIFix3i2sQMkSYB503LrAOzgRqlMWo++g1YuvdPEo6t86wov5MCHjXs98iCH33HE/I7QnMtP3RCdLksKaGgiQp9q91jHugiI/64E6ViYtIGeuMQD1+JmuaLk6has8=
Received: from CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17)
 by CH0PR12MB5041.namprd12.prod.outlook.com (2603:10b6:610:e0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Thu, 5 Aug
 2021 09:18:47 +0000
Received: from CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::c803:b1ae:e7f8:fe87]) by CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::c803:b1ae:e7f8:fe87%2]) with mapi id 15.20.4394.017; Thu, 5 Aug 2021
 09:18:47 +0000
From: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Nieto, David M" <David.Nieto@amd.com>, "Deng, Emily"
 <Emily.Deng@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable more pm sysfs under SRIOV 1-VF mode
Thread-Topic: [PATCH] drm/amdgpu: enable more pm sysfs under SRIOV 1-VF mode
Thread-Index: AQHXiQVtEMExS22O/UmEEi2kycEOx6ti/PlwgAF3/OCAACu8gIAAAsMw
Date: Thu, 5 Aug 2021 09:18:47 +0000
Message-ID: <CH0PR12MB51567C449C2DEFE9DC518A1AF8F29@CH0PR12MB5156.namprd12.prod.outlook.com>
References: <20210804075024.9407-1-Jiawei.Gu@amd.com>
 <CH0PR12MB5156021023502CABB4EAE1F8F8F19@CH0PR12MB5156.namprd12.prod.outlook.com>
 <CH0PR12MB51564DA6D0636BE10183A79AF8F29@CH0PR12MB5156.namprd12.prod.outlook.com>
 <74fa9879-6f8c-d849-b9a4-a5ddd6fe3c04@amd.com>
In-Reply-To: <74fa9879-6f8c-d849-b9a4-a5ddd6fe3c04@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-05T09:18:43Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=588c6557-479e-4a3d-b1b6-7412ef1ad142;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3d7e9f3-f95b-44d2-5bd9-08d957f207e5
x-ms-traffictypediagnostic: CH0PR12MB5041:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB5041A2D3DECC90D5A4696C6AF8F29@CH0PR12MB5041.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3o+Wwv690V5hOjnP7xqEU+wWu6vpHpyqpdR1VLMexr5gFMYrjQI9oRUdZsrvmVqGikORT+ZR4aumE7Iy2AXy0N9ZjCav9JrbBFZ1wUQnycg1mQHIKY0nrv5BFlZ6D3AlPCrBChD0JO3pMrko4vCkxQlQBU8XS7sxYHyIKqV2+Lw3VsjfrjghcdznxZwnr4/JGKM08AILJ9wiqCJyKxhS8FkbB4D5tksAAexYIwKdSt1qrVGr8pv/DLonkTmQGGFKu/QN+jG+gx7sMT6Kh93WGCvc6DSujjhhPWCRWUzYI5CjjH8kJcEuLr+chmumOBblPLGcL5CGU+OQX0HA1utAQjj4W/NPHhh6W7THz35dlp4u3Gixq78gQEpH05QaMejV+sRgUXsad/pqFAaK+vmXRaxq+xg/NG2nTHWGoIhzk8cVNbJtAi0zPQEUSnAaFJKGqDChmMREMbDnhj3ufWM8QxKnPJi54vLD29TG3LTNLGpf46PeIGE5xnnbeq9FJ8i1nqi6GdgwGNAER5kN/4Mjyc/bpyjWnBzY9bPhIV0IlRVgRJZE5WbDJywr2wONc+K7psR4vXaLosxCJdnto2sl9zOTiQ3zZJY0y6aQyWvvNowVj1z8kqhAa9y3BrHw8WH9Ha/PY5d06OV72ZgTnuhZD+O6wo+z66ui5goubn8xb4qW8QugbHmwIg035h/CCsM8vCWdzMThzP7/7nGQTnKqmg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(26005)(2906002)(52536014)(86362001)(71200400001)(83380400001)(33656002)(122000001)(5660300002)(4326008)(186003)(38100700002)(316002)(110136005)(53546011)(9686003)(478600001)(54906003)(66946007)(7696005)(8936002)(38070700005)(76116006)(6506007)(66446008)(66556008)(66476007)(64756008)(8676002)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmRQa1hiSG1FZElFL0JTZFN1S3YrOUhlZG5iWkF4dm5HS3RobWdaNWtuRG5q?=
 =?utf-8?B?alhaQlJSNndSVDA4Vm8vcEcvaks1SkpqSHBTMEpJenlBMXBnbUdTMk5SR0xQ?=
 =?utf-8?B?d0FmSkVkS1BXU2ttbWNsaUNQaUhFOFZVSEJoUGwzRFpWcjkwcU0yV1dvR1Ns?=
 =?utf-8?B?VStwaCtyZ1VQQ3drdlZjeDR3RVRTMmRXMHZvbFBZSklFZ2FyTmsyczAxUUV4?=
 =?utf-8?B?aXJiSjFzMXBla3JRSkNOK0pPK1JaQ0cyWGdSODQyQWQ3aTNaR0FDV0hsSi8w?=
 =?utf-8?B?Z0JIbnZHK3o3b1ZMMCtpaHgwaXRQUnBycVRDakRyK0xGUG50WlRXaGxkTE1i?=
 =?utf-8?B?Uno1cG5yWWpEeXZLZkgxTkhDZE1iQ291Q0tNWHBWS1ZpYXE0emxNMjN6bWpE?=
 =?utf-8?B?RUQ2TU5JR0JiTjE2Nk5KSVg2K2VNRHEyd0pmZFFnbDJaK3FkL2drZjRseWFt?=
 =?utf-8?B?MmZyeDEzeFc5OHNrV052bVlNUEF5UmNTRDNNQ2VCZ2tDWWxPTzVqQjBEejVz?=
 =?utf-8?B?OGkrc09LRElOZ1YzelJxU2F0S2ZyRVlUbVdYRldkM1RZbGt2OWFDbVFQUisv?=
 =?utf-8?B?dzRtekMxd3ArUGdzSUdMbFBaQ1pDYkprT1QyOFJRcHZtbDVsYTVHTjUyRHJU?=
 =?utf-8?B?cFFjRHU2UC85dElYWnVJVWdjWVNxVzRXYnRpUFp5bkxaTGhWdEdxTVZ3UEth?=
 =?utf-8?B?QTRadjFvY1Y2SDhRbUIySmMzdkltVUZYUnB1eUdJOUNJM2dqS1JFLzZtSHg1?=
 =?utf-8?B?cHZiTXI1Qlo2cDJBMmUzL3FQVm9DTWxrckVpd1VmNUozdE1CM0cxNGF4cXhZ?=
 =?utf-8?B?R3ovMEtoN04wRm8vdDBrSit2azBrdlZRUEd1UUVSZnZqUzhJcnFBV1VBYWxz?=
 =?utf-8?B?SGdvZlo4bm82SUxpWitrUlJiM3RZak5vNWRJMFd4UDRRZGNvN0JQU0NrMDVT?=
 =?utf-8?B?c2tWdi9IMktGZTVaNTAyY25PWDZzMWNZSG93Z1NVbVkrdWo5NUdJenpoQjQ5?=
 =?utf-8?B?c0pRamx5VTdnSjFXaVpVMVNnQjMwL2N4dzBOc2IyWm13Vm0xcWVqZmRYamRE?=
 =?utf-8?B?WlRHVGVnU1l3QTN2WGZJQzcxYm5YMjN5UmIwdStnOXFremFURWxhay9QR0lN?=
 =?utf-8?B?YnR4MGxyODBmbFlpTnlYM29qVFJ5aE1uNG9nZ1pDQkk0dUtZcXhnYlVIYkFs?=
 =?utf-8?B?eVFwbVlVSTYwNnNjdkxFdmtNV04xS0MvZTdwOWE0aDFMS0NBN1pFZGN4VTVt?=
 =?utf-8?B?UVlUdmdIV3JzaDUxUUJzQ1JSeHpMNFJVSENRSzc0dzlDdktvb3IvVzlCdGZ6?=
 =?utf-8?B?ZzJPZGVpbUZndzVkUnJ3SUtxcDhYc3BQdXFOTG54U3k0NnhPcElTUU04L3hR?=
 =?utf-8?B?cmMvN0FBYTg5YmZmVWY4Z1cwbGx0bC9xcVNGclJQZ1k0Y01vaXowalVSekJI?=
 =?utf-8?B?OFpiOStPaEhQMzJEQWRDeEFQc01rSHJsUTEvZWk5TG9NWVMzdStoa1RGNFl4?=
 =?utf-8?B?K2owZDFyd3RMT293RXU4bVF5V3ZTRitBaGdpUE5udHUvRzFKUzNFNzN2M2VV?=
 =?utf-8?B?dWd1WUd4VjlualE1WVJFSndxSW9qRllWTnhNVWxWRk90YjZXekZnZER5UnA2?=
 =?utf-8?B?ZjBwUzgzc3hWWE5xYXlCVHE5a25qOWhTU3hTTTBTVFh1ekZwM3VWU3Zkb1BL?=
 =?utf-8?B?RVVzeHR2YUJuZlhSbU1pR0J3ejJiOWM3VU5ISWd1bnYvb0d6NHRjdjFMdTU1?=
 =?utf-8?Q?9An9Qr7XUjBy2X1fR4CTnVHiTC/q6IYACnYU2pl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d7e9f3-f95b-44d2-5bd9-08d957f207e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2021 09:18:47.4535 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5HVGd76AKReH6dcLrnJYL9u54+oeIZ2UNLRi0q+tu4oMGdK0vAGTCgxCD9O9i8I55zjhCGKlKJ0W8pVmWfdtAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5041
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgTGlqbywNCg0KSXQncyBmb3IgTmF2aTEyIGFz
aWMgYXMgZmFyIGFzIEkga25vdy4NCg0KQmVzdCByZWdhcmRzLA0KSmlhd2VpDQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29t
PiANClNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgNSwgMjAyMSA1OjA4IFBNDQpUbzogR3UsIEppYVdl
aSAoV2lsbCkgPEppYVdlaS5HdUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCkNjOiBOaWV0bywgRGF2aWQgTSA8RGF2aWQuTmlldG9AYW1kLmNvbT47IERlbmcsIEVtaWx5
IDxFbWlseS5EZW5nQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVj
aGVyQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBlbmFibGUgbW9y
ZSBwbSBzeXNmcyB1bmRlciBTUklPViAxLVZGIG1vZGUNCg0KDQoNCk9uIDgvNS8yMDIxIDEyOjAx
IFBNLCBHdSwgSmlhV2VpIChXaWxsKSB3cm90ZToNCj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seV0N
Cj4gDQo+IFBpbmcuDQo+IA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBH
dSwgSmlhV2VpIChXaWxsKSA8SmlhV2VpLkd1QGFtZC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwg
QXVndXN0IDQsIDIwMjEgNDowOCBQTQ0KPiBUbzogR3UsIEppYVdlaSAoV2lsbCkgPEppYVdlaS5H
dUBhbWQuY29tPjsgDQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBOaWV0
bywgRGF2aWQgTSA8RGF2aWQuTmlldG9AYW1kLmNvbT47IERlbmcsIEVtaWx5IA0KPiA8RW1pbHku
RGVuZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIXSBkcm0vYW1kZ3B1OiBlbmFibGUgbW9yZSBwbSBz
eXNmcyB1bmRlciBTUklPViAxLVZGIA0KPiBtb2RlDQo+IA0KPiBbQU1EIE9mZmljaWFsIFVzZSBP
bmx5XQ0KPiANCj4gQWRkIEFsZXguDQo+IA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBKaWF3ZWkgR3UgPEppYXdlaS5HdUBhbWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXks
IEF1Z3VzdCA0LCAyMDIxIDM6NTAgUE0NCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQo+IENjOiBOaWV0bywgRGF2aWQgTSA8RGF2aWQuTmlldG9AYW1kLmNvbT47IERlbmcsIEVt
aWx5IA0KPiA8RW1pbHkuRGVuZ0BhbWQuY29tPjsgR3UsIEppYVdlaSAoV2lsbCkgPEppYVdlaS5H
dUBhbWQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IGVuYWJsZSBtb3JlIHBt
IHN5c2ZzIHVuZGVyIFNSSU9WIDEtVkYgDQo+IG1vZGUNCj4gDQo+IEVuYWJsZSBwcF9udW1fc3Rh
dGVzLCBwcF9jdXJfc3RhdGUsIHBwX2ZvcmNlX3N0YXRlLCBwcF90YWJsZSBzeXNmcyB1bmRlciBT
UklPViAxLVZGIHNjZW5hcmlvLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmlhd2VpIEd1IDxKaWF3
ZWkuR3VAYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVf
cG0uYyB8IDggKysrKy0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
YW1kZ3B1X3BtLmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYw0KPiBp
bmRleCA3NjlmNThkNWFlMWEuLjA0YzdkODJmOGI4OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L2FtZGdwdV9wbS5jDQo+IEBAIC0yMDA1LDEwICsyMDA1LDEwIEBAIHN0YXRpYyBpbnQgc3NfYmlh
c19hdHRyX3VwZGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV9k
ZXZpY2VfICBzdGF0aWMgc3RydWN0IGFtZGdwdV9kZXZpY2VfYXR0ciBhbWRncHVfZGV2aWNlX2F0
dHJzW10gPSB7DQo+ICAgCUFNREdQVV9ERVZJQ0VfQVRUUl9SVyhwb3dlcl9kcG1fc3RhdGUsCQkJ
CUFUVFJfRkxBR19CQVNJQ3xBVFRSX0ZMQUdfT05FVkYpLA0KPiAgIAlBTURHUFVfREVWSUNFX0FU
VFJfUlcocG93ZXJfZHBtX2ZvcmNlX3BlcmZvcm1hbmNlX2xldmVsLAlBVFRSX0ZMQUdfQkFTSUN8
QVRUUl9GTEFHX09ORVZGKSwNCj4gLQlBTURHUFVfREVWSUNFX0FUVFJfUk8ocHBfbnVtX3N0YXRl
cywJCQkJQVRUUl9GTEFHX0JBU0lDKSwNCj4gLQlBTURHUFVfREVWSUNFX0FUVFJfUk8ocHBfY3Vy
X3N0YXRlLAkJCQlBVFRSX0ZMQUdfQkFTSUMpLA0KPiAtCUFNREdQVV9ERVZJQ0VfQVRUUl9SVyhw
cF9mb3JjZV9zdGF0ZSwJCQkJQVRUUl9GTEFHX0JBU0lDKSwNCj4gLQlBTURHUFVfREVWSUNFX0FU
VFJfUlcocHBfdGFibGUsCQkJCQlBVFRSX0ZMQUdfQkFTSUMpLA0KDQo+ICsJQU1ER1BVX0RFVklD
RV9BVFRSX1JPKHBwX251bV9zdGF0ZXMsCQkJCUFUVFJfRkxBR19CQVNJQ3xBVFRSX0ZMQUdfT05F
VkYpLA0KPiArCUFNREdQVV9ERVZJQ0VfQVRUUl9STyhwcF9jdXJfc3RhdGUsCQkJCUFUVFJfRkxB
R19CQVNJQ3xBVFRSX0ZMQUdfT05FVkYpLA0KPiArCUFNREdQVV9ERVZJQ0VfQVRUUl9SVyhwcF9m
b3JjZV9zdGF0ZSwJCQkJQVRUUl9GTEFHX0JBU0lDfEFUVFJfRkxBR19PTkVWRiksDQoNCldoaWNo
IEFTSUMgaXMgdGhpcyBmb3I/IEFzIGZhciBhcyBJIHNlZSBmcm9tIHRoZSBjdXJyZW50IGltcGxl
bWVudGF0aW9uLCBwb3dlciBzdGF0ZSBpcyBub3Qgc3VwcG9ydGVkIGluIHN3c211IHByb2plY3Rz
Lg0KDQpUaGFua3MsDQpMaWpvDQoNCj4gKwlBTURHUFVfREVWSUNFX0FUVFJfUlcocHBfdGFibGUs
CQkJCQlBVFRSX0ZMQUdfQkFTSUN8QVRUUl9GTEFHX09ORVZGKSA+ICAgCUFNREdQVV9ERVZJQ0Vf
QVRUUl9SVyhwcF9kcG1fc2NsaywJCQkgDQpBVFRSX0ZMQUdfQkFTSUN8QVRUUl9GTEFHX09ORVZG
KSwNCj4gICAJQU1ER1BVX0RFVklDRV9BVFRSX1JXKHBwX2RwbV9tY2xrLAkJCQlBVFRSX0ZMQUdf
QkFTSUN8QVRUUl9GTEFHX09ORVZGKSwNCj4gICAJQU1ER1BVX0RFVklDRV9BVFRSX1JXKHBwX2Rw
bV9zb2NjbGssCQkJCUFUVFJfRkxBR19CQVNJQ3xBVFRSX0ZMQUdfT05FVkYpLA0KPiAtLQ0KPiAy
LjE3LjENCj4gDQo=
