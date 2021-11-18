Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C62C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 10:36:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F4761B39
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 10:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A5F4761B39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 501916EA00;
	Thu, 18 Nov 2021 10:36:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCB576EA00
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 10:36:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnBvDVSwMC2y2BwnNIvX3Et6D1dxKSs/OJs00/HoYBHRr8TA3rZrwUWtDDXNkwuPjj5tsrR9YK724wQp+L77AASowt7V6OIYrFPbRUOVSejMUFlfjNv0pMPHZJ+onaWmF7E++CbLBUW24DM18EVXq8Eijz7hCQTUitYxnLb1zr9u1++j33ZVtqYUEEbIhgYUvkedanV2YsS9goklTeJYpBDWvtbcHW3CnF55n7pRa+WbxzLXU3nQN39Cvg5jthhTbWMXS656N6HXDReSuCypc4c2SLooDcmUwx+IQ6xH6Q18DYhomAtiqLULL8zWrrvlG05Q5nq+Lplf8li789Pk6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRrKiwBAQcmUcXuBQmb1gDjvf+oQi1Afqqo2Y2/ISQo=;
 b=NSQYn8Ff4H7ZhGeZsbhdakjoxyZ/waKrsJllODB8uQ+6+IhztTLQ4PjA4OfHDH+mReYeHbsnCqZe7as31hvxKbkza1gfasPyqTVbR7DDkIgOn6HclJkS82TqihPOl9q+YeFLg3cERohAP8gpkmlXOV0awF4WVRkvXH224vSZ6ztYPy+N6+euyDhYgO8fXtz5TCY9f4VrrOYX/4yIk/t+eAuO8DhW0zsKtQBcJhtdf+t91TJ758GHcwgTps3hytPeh1KnwlusJnAKbuYx8dtjGCIlErT26nrdr9DyK4V2002ZWisyFf4noxaTGMbsxjBhwvW5UNxe8aZhEaMr+fWSwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRrKiwBAQcmUcXuBQmb1gDjvf+oQi1Afqqo2Y2/ISQo=;
 b=UXYVtWRBA4r8CvjNaZXxsMpnaH5lD6wJcoaeuZPCCWOdBwqSJfZTXoTRK4zXxI0xvV6dUNVsJkz9XocFQCrX2Zwz7kECh0YSE8DBRiv9wvqnjDB+gvQGXi5pv2aQZ8JMYb7kmpbzKdv2lw5cuneBwVwbtELQrktYJK+ffuWmEm4=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by BL1PR12MB5078.namprd12.prod.outlook.com (2603:10b6:208:313::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 18 Nov
 2021 10:36:41 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::7cc0:c568:c7b1:d824]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::7cc0:c568:c7b1:d824%5]) with mapi id 15.20.4669.016; Thu, 18 Nov 2021
 10:36:41 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, 
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggUmV2aWV3IDEvNF0gZHJtL2FtZGdwdTogVXBkYXRl?=
 =?utf-8?Q?_smu_driver_interface_for_aldebaran?=
Thread-Topic: [PATCH Review 1/4] drm/amdgpu: Update smu driver interface for
 aldebaran
Thread-Index: AQHX3F9kJLrWHTdJPU65SXz9jp4HrKwJDO2AgAAKZTA=
Date: Thu, 18 Nov 2021 10:36:40 +0000
Message-ID: <BL1PR12MB53344DA5C12BD4D9F1D266029A9B9@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20211118093344.4361-1-Stanley.Yang@amd.com>
 <DM6PR12MB2619F27FA83AD0C14BD2AC9DE49B9@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619F27FA83AD0C14BD2AC9DE49B9@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-18T09:58:27Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d2211935-07f0-44c5-8284-c31b328c5197;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-11-18T10:36:38Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 0619aaf3-6c13-4518-b32b-e218f61e32ee
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebe4b4cf-9f5c-4706-44b3-08d9aa7f4ed9
x-ms-traffictypediagnostic: BL1PR12MB5078:
x-microsoft-antispam-prvs: <BL1PR12MB5078543CEC882AC2E3566B959A9B9@BL1PR12MB5078.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dvKjlQlzboJwKbJ9G7LmNvlVuzZHVqJ5Nz1amXDK/Sjr6ZgRbd9pAIRo3cZMJpYeSV1ICMrwQfEQkg3dYvxnrttBzAPO2/QS5xRkeOAoZcZjcx6n8Mam6U67fhkiur+XWCx+1AiQt345N9/tfoV4v4fi3/8wteRXRiorYNlxTU6IAk8WuQ+tj6WLB9TlRXjpQST/f6FRattSwr1Yt5ONpQwK+GTPwo4/S7IjJFKWHYuwwapRxUaLhWWSJUr07f/eU8v1rOX58vJmuAnvwZPcGS3/kHCzj52qj/Mt0fiZTv8AQmMOnPlW3PhnMd4pVt8ixg6V0FH5dJ68w/BLB9B0WNATWr21mw7rwzhpb2qsb5aQ78XQwY9uxfPqr+DMgCyuup376JDUy9PcHqQpAb7yFfV+3mYhtECGxcwDJbUI8WgCz5pUMZxTMZnw9y5xquuBdWMh+cZZ6O1QIe6m9GUTc5C00HmwdB+oNSAWRq84WxVOOgzxSW4WYEhYdj1Cu3Oc/At5QLrEPYRAwMteeNxOTErYG9uqkGRlRpbtG2jHkgYStOosFm0D0cPHJkFA4OZlownZLh1gENhe+d/y9dxmhWzdbp+YRM85NBu4vyRUpETWNqgL9mQ9pTvS990t+hhyNU2zdQxZ1W7H740UihJlqKbYfmX+VkBiO7wRD9RTfVaH4WCaxJKkVMwQRi3hdxDN/OYiv8lW09G2DryHehcdqm6Qk9tyNJ+hrblfk1sETpc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(53546011)(71200400001)(52536014)(6506007)(26005)(86362001)(6636002)(38100700002)(55016002)(15650500001)(7696005)(5660300002)(83380400001)(122000001)(224303003)(508600001)(66476007)(66946007)(64756008)(186003)(66556008)(8936002)(9686003)(316002)(19627235002)(76116006)(921005)(2906002)(33656002)(110136005)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUlqeHZmQTVBRUc2anJqWGVvNnZMQkg5a09tTjBNVGhYQ01VbzZpT01qUGpu?=
 =?utf-8?B?U2l2VFdBWFZuWFdBYUtmMWNRcEsyS2VYM0lteCtTNHFaL3RNRmFtQW56c0Yw?=
 =?utf-8?B?WEZiWTBQaHAvRlhxdCt2ZWxpbzA4NWdQbzRHZXkyWmJHcnluQTg1VUxNZjFv?=
 =?utf-8?B?dFVZbkJSRy8xVUw5S1B2VnR4eFFEOWphSldLOVRqTzBENkhjYlR0MlFSUFFS?=
 =?utf-8?B?WU1INjJRQXFWdkI3VStPelFzdGNoVWhFbGpUSlJpZGVBajd2MWxTcXNLbWJa?=
 =?utf-8?B?QkV1eDZ4Sm1kTXY0MUZERjNEZGt1ZkFCS2lpcU9PMnFvaG9SVmFvMENXdDBT?=
 =?utf-8?B?YUNHZm03QUNuUlZadEgzSEYvNjlFWDFvNVRZVzNNbmNiZ2RjNmFKVmtCSFVl?=
 =?utf-8?B?Ti9NUGU2TWpTMk1BZ0kxelVPTEFPTG1MQklQcVMrUlJXaVZzNW1UNEpvYTFv?=
 =?utf-8?B?L0pKaEhCK2RpSlIrcXI2WWtnVjEwdlQrL085V2ROZXhNQzdYN3V1aVdMZzBw?=
 =?utf-8?B?TndlNkpBWEhkZGtJeHdiQXp4RWdmNHgyOWNzRXRqVHJ1NUFiaEZyVFlPTkpE?=
 =?utf-8?B?c2lQQzc2YzRtQTJmVm85VzRuTXVvenJTMUJpUEdYZ0N1QmZrdktNc3RFR1l3?=
 =?utf-8?B?QVZud2hpSHpudlgvZkRQd2VpNlA3UW4vNU1VU1U3YVkrQTZXSm11ZmZ0cnBs?=
 =?utf-8?B?d0FjWUNidFF4d0JxVHVDSVNCTi9DYzFodWV1UTg5aUYzNkVwVjhMNWc4cHdK?=
 =?utf-8?B?b2s0VmNxYWthR2ZDQ0tUUUk5UkVtWlJXMWc0Y2kxNitlQ1NlWlFLZE11N0Ir?=
 =?utf-8?B?MnFCWWZYcGdXc29Tc2ZtTDlBMFVNNFhSL1M4UnlkZXllcm82eHI0N2R2TUR4?=
 =?utf-8?B?QSt4NnFlc0toZCtRSlMxSjJDZFEwbkF6OWRXcm5KNUhKY0VjS3podWpXc2NO?=
 =?utf-8?B?RU9RM2RyQ2RuQzJ6NU1CK1BFUGhtMnJ0QTRTZ2JmaVB1N2paRnBCT3M0N0VI?=
 =?utf-8?B?V3FvSE9xUThhK1FlUitmSnNiUER6ZXJXTnk5WFJUNWJaQUtJTXpyWUJMUmw2?=
 =?utf-8?B?ckR6V1lsU3VFK1BtazNlc0NFWU1CYmp6cktqeVRBOU1jaDdhNVJnZ2tGTE44?=
 =?utf-8?B?NUtVL2hrRE0yMGNOQkVmbUJkdkk0MS9UQUU0bGZ0a2VSaFA3STB4cVErZUM2?=
 =?utf-8?B?Q0Ixd2dTWkl0b1ZlcW5DdFVHRzdTK1VLcEdGUlMyRnJKa0x4SWg2UUlWeWVB?=
 =?utf-8?B?U210d0xSakxqMk1Cb1NnUlZnZFRFQ0ZDRUk2STdmTGtSeVB1R1AzZjI3M2RT?=
 =?utf-8?B?SzkvS2lnRFlVUlZraUhwL2M0cEJZTUxKK2NNMzRaYndxcWRXbGliNml0Mldu?=
 =?utf-8?B?a1Y4TUdZZlo0N3lSRFI1QVBTMHVWVlVodlU1ekZyL3ZVcENEYU5uakhEbWZX?=
 =?utf-8?B?TjRPem9TT042Tk54UlQ2R3E3ODErR0IzSHZmSVNHcUw2NDZyR0tKVGxzZTdl?=
 =?utf-8?B?T0RYVk1qZExvejRjUi9SK29yWmVjWFg1b1ZWaXNJQ004YzAwdWJBUlpjSGRt?=
 =?utf-8?B?SG5mV0RLczhQbFRFUUw1d3RJanJEMmp1bkl3RDRRNDQxZnU2dHpjeHVxQmxm?=
 =?utf-8?B?VVgrQXg4QWF3bGlKZ2R2Vm9QcjlnTDl2Wm45VTRrOHF4WkMwdGg5OGFOMEor?=
 =?utf-8?B?cGZxVlc5TUdCR2gwYWVxSmtRVjZMOWZBWDg0M2h3Z1JsejVWQ3Z5aG5TbWFi?=
 =?utf-8?B?REJ5L2NERE1qNWNmVFJGNGlHNTg1aFhkSWpKb21NL1hubWZmbUYxMWdmdW8v?=
 =?utf-8?B?NDc3V3BzVlhjSHFNdG1wc2E5NTVIRHhwSld4Y0I5bDJUeTFEVXlDMkxWWU56?=
 =?utf-8?B?bVZUeTJ3UlpmL1YzR1piQnFxQlNaZzZ5eFdCajJEU0JzcDBRVnBrQ2JFOUt0?=
 =?utf-8?B?ZzFKTGVWVnJhQnh4d0RVNTl5YlB6NU1WQjJIYWdHcjVoVWc3UUJXM29xdXpK?=
 =?utf-8?B?ajVWMUQ2UmRXZzA0ZUxraXpFbWNaNlMwL0c5cExnRWt4OGdEcUdrQ3JObXht?=
 =?utf-8?B?eHdWWDhyQUZnQk1iTVRkRjI2ZVdlOHNOUm53aWN3cFhZTEUrZStHN1ExUUdD?=
 =?utf-8?B?V0QvbVZTRUhUOUNMenlpNkJVb1NKeFNvQytiamF0OEpHbko2MFpMTFJTZjFG?=
 =?utf-8?Q?HigoAzLxRRz0Mx1IesKjcVU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe4b4cf-9f5c-4706-44b3-08d9aa7f4ed9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 10:36:40.7985 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P5GCgisYwiev9ebc/4vMA2OqIozmBnSMsyJsGqAVOu3KJwO9BNvVyw+Bo2kCTEn/FpBgvd0t1+UJb2FdEA4K9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5078
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KVGhhbmtzIEV2YW4sDQoNCldpbGwgdXBkYXRlIHBh
dGNoIDEgYW5kIDMgdGl0bGUgYmVmb3JlIHN1Ym1pdC4NCg0KUmVnYXJkcywNClN0YW5sZXkNCj4g
LS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IFF1YW4sIEV2YW4gPEV2YW4uUXVh
bkBhbWQuY29tPg0KPiDlj5HpgIHml7bpl7Q6IFRodXJzZGF5LCBOb3ZlbWJlciAxOCwgMjAyMSA1
OjU4IFBNDQo+IOaUtuS7tuS6ujogWWFuZywgU3RhbmxleSA8U3RhbmxleS5ZYW5nQGFtZC5jb20+
OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFpoYW5nLCBIYXdraW5nIDxIYXdr
aW5nLlpoYW5nQGFtZC5jb20+Ow0KPiBDbGVtZW50cywgSm9obiA8Sm9obi5DbGVtZW50c0BhbWQu
Y29tPjsgTGF6YXIsIExpam8NCj4gPExpam8uTGF6YXJAYW1kLmNvbT47IFdhbmcsIFlhbmcoS2V2
aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQuY29tPg0KPiDmioTpgIE6IFlhbmcsIFN0YW5sZXkgPFN0
YW5sZXkuWWFuZ0BhbWQuY29tPg0KPiDkuLvpopg6IFJFOiBbUEFUQ0ggUmV2aWV3IDEvNF0gZHJt
L2FtZGdwdTogVXBkYXRlIHNtdSBkcml2ZXIgaW50ZXJmYWNlIGZvcg0KPiBhbGRlYmFyYW4NCj4g
DQo+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHldDQo+IA0KPiBCZXR0ZXIgdG8gdXBkYXRlIHRoZSBw
YXRjaCB0aXRsZSBhcyAiZHJtL2FtZC9wbTogVXBkYXRlIHNtdSBkcml2ZXINCj4gaW50ZXJmYWNl
IGZvciBhbGRlYmFyYW4iIGFzIGFsbCBvdGhlciBwb3dlciByZWxhdGVkIHBhdGNoZXMuDQo+IEFu
ZCBwbGVhc2UgdXBkYXRlIHBhdGNoMyBhbHNvLg0KPiBPdGhlciB0aGFuIGFib3ZlLCBwYXRjaCAx
LCAzIGFyZSByZXZpZXdlZC1ieTogRXZhbiBRdWFuDQo+IDxldmFuLnF1YW5AYW1kLmNvbT4NCj4g
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFN0YW5sZXkuWWFuZyA8U3Rh
bmxleS5ZYW5nQGFtZC5jb20+DQo+ID4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDE4LCAyMDIx
IDU6MzQgUE0NCj4gPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFpoYW5nLCBI
YXdraW5nDQo+ID4gPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IENsZW1lbnRzLCBKb2huDQo+IDxK
b2huLkNsZW1lbnRzQGFtZC5jb20+OyBRdWFuLA0KPiA+IEV2YW4gPEV2YW4uUXVhbkBhbWQuY29t
PjsgTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT47IFdhbmcsDQo+ID4gWWFuZyhLZXZp
bikgPEtldmluWWFuZy5XYW5nQGFtZC5jb20+DQo+ID4gQ2M6IFlhbmcsIFN0YW5sZXkgPFN0YW5s
ZXkuWWFuZ0BhbWQuY29tPg0KPiA+IFN1YmplY3Q6IFtQQVRDSCBSZXZpZXcgMS80XSBkcm0vYW1k
Z3B1OiBVcGRhdGUgc211IGRyaXZlciBpbnRlcmZhY2UNCj4gPiBmb3IgYWxkZWJhcmFuDQo+ID4N
Cj4gPiB1cGRhdGUgc211IGRyaXZlciBpZiB2ZXJzaW9uIHRvIDB4MDggdG8gYXZvaWQgbWlzbWF0
Y2ggbG9nIEEgdmVyc2lvbg0KPiA+IG1pc21hdGNoIGNhbiBzdGlsbCBoYXBwZW4gd2l0aCBhbiBv
bGRlciBGVw0KPiA+DQo+ID4gQ2hhbmdlLUlkOiBJOTdmMmJjNGVkOWE5Y2JhMzEzYjc0NGUyZmY2
ODEyYzkwYjI0NDkzNQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFN0YW5sZXkuWWFuZyA8U3RhbmxleS5Z
YW5nQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9kcm0vYW1kL3BtL2luYy9zbXUxM19kcml2
ZXJfaWZfYWxkZWJhcmFuLmggfCAxOA0KPiA+ICsrKysrKysrKysrKysrKysrLQ0KPiA+ICBkcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9zbXVfdjEzXzAuaCAgICAgICAgIHwgIDIgKy0NCj4gPiAg
MiBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vaW5jL3NtdTEzX2RyaXZlcl9p
Zl9hbGRlYmFyYW4uaA0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvc211MTNfZHJp
dmVyX2lmX2FsZGViYXJhbi5oDQo+ID4gaW5kZXggYTAxNzk4M2ZmMWZhLi4wZjY3YzU2YzI4NjMg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvc211MTNfZHJpdmVy
X2lmX2FsZGViYXJhbi5oDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvc211
MTNfZHJpdmVyX2lmX2FsZGViYXJhbi5oDQo+ID4gQEAgLTE0MCw2ICsxNDAsOCBAQA0KPiA+DQo+
ID4gICNkZWZpbmUgTUFYX1NXX0kyQ19DT01NQU5EUyAgICAgICAgICAgICAgICAyNA0KPiA+DQo+
ID4gKyNkZWZpbmUgQUxERUJBUkFOX1VNQ19DSEFOTkVMX05VTSAgICAzMg0KPiA+ICsNCj4gPiAg
dHlwZWRlZiBlbnVtIHsNCj4gPiAgICBJMkNfQ09OVFJPTExFUl9QT1JUXzAsIC8vQ0tTVklJMkMw
DQo+ID4gICAgSTJDX0NPTlRST0xMRVJfUE9SVF8xLCAvL0NLU1ZJSTJDMQ0KPiA+IEBAIC01MDcs
NiArNTA5LDE5IEBAIHR5cGVkZWYgc3RydWN0IHsNCj4gPiAgICB1aW50MzJfdCBNbUh1YlBhZGRp
bmdbOF07IC8vIFNNVSBpbnRlcm5hbCB1c2UgIH0gQXZmc0RlYnVnVGFibGVfdDsNCj4gPg0KPiA+
ICt0eXBlZGVmIHN0cnVjdCB7DQo+ID4gKwl1aW50NjRfdCBtY2FfdW1jX3N0YXR1czsNCj4gPiAr
CXVpbnQ2NF90IG1jYV91bWNfYWRkcjsNCj4gPiArCXVpbnQxNl90IGNlX2NvdW50X2xvX2NoaXA7
DQo+ID4gKwl1aW50MTZfdCBjZV9jb3VudF9oaV9jaGlwOw0KPiA+ICsNCj4gPiArCXVpbnQzMl90
IGVjY1BhZGRpbmc7DQo+ID4gK30gRWNjSW5mb190Ow0KPiA+ICsNCj4gPiArdHlwZWRlZiBzdHJ1
Y3Qgew0KPiA+ICsJRWNjSW5mb190ICBFY2NJbmZvW0FMREVCQVJBTl9VTUNfQ0hBTk5FTF9OVU1d
Ow0KPiA+ICt9IEVjY0luZm9UYWJsZV90Ow0KPiA+ICsNCj4gPiAgLy8gVGhlc2UgZGVmaW5lcyBh
cmUgdXNlZCB3aXRoIHRoZSBmb2xsb3dpbmcgbWVzc2FnZXM6DQo+ID4gIC8vIFNNQ19NU0dfVHJh
bnNmZXJUYWJsZURyYW0yU211DQo+ID4gIC8vIFNNQ19NU0dfVHJhbnNmZXJUYWJsZVNtdTJEcmFt
DQo+ID4gQEAgLTUxNyw2ICs1MzIsNyBAQCB0eXBlZGVmIHN0cnVjdCB7DQo+ID4gICNkZWZpbmUg
VEFCTEVfU01VX01FVFJJQ1MgICAgICAgICAgICAgNA0KPiA+ICAjZGVmaW5lIFRBQkxFX0RSSVZF
Ul9TTVVfQ09ORklHICAgICAgIDUNCj4gPiAgI2RlZmluZSBUQUJMRV9JMkNfQ09NTUFORFMgICAg
ICAgICAgICA2DQo+ID4gLSNkZWZpbmUgVEFCTEVfQ09VTlQgICAgICAgICAgICAgICAgICAgNw0K
PiA+ICsjZGVmaW5lIFRBQkxFX0VDQ0lORk8gICAgICAgICAgICAgICAgIDcNCj4gPiArI2RlZmlu
ZSBUQUJMRV9DT1VOVCAgICAgICAgICAgICAgICAgICA4DQo+ID4NCj4gPiAgI2VuZGlmDQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vaW5jL3NtdV92MTNfMC5oDQo+ID4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9zbXVfdjEzXzAuaA0KPiA+IGluZGV4IGJiYzYw
OGM5OTBiMC4uNDRhZjIzYWUwNTllIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG0vaW5jL3NtdV92MTNfMC5oDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9p
bmMvc211X3YxM18wLmgNCj4gPiBAQCAtMjcsNyArMjcsNyBAQA0KPiA+DQo+ID4gICNkZWZpbmUg
U01VMTNfRFJJVkVSX0lGX1ZFUlNJT05fSU5WIDB4RkZGRkZGRkYgICNkZWZpbmUNCj4gPiBTTVUx
M19EUklWRVJfSUZfVkVSU0lPTl9ZRUxMT1dfQ0FSUCAweDA0IC0jZGVmaW5lDQo+ID4gU01VMTNf
RFJJVkVSX0lGX1ZFUlNJT05fQUxERSAweDA3DQo+ID4gKyNkZWZpbmUgU01VMTNfRFJJVkVSX0lG
X1ZFUlNJT05fQUxERSAweDA4DQo+ID4NCj4gPiAgI2RlZmluZSBTTVUxM19NT0RFMV9SRVNFVF9X
QUlUX1RJTUVfSU5fTVMgNTAwICAvLzUwMG1zDQo+ID4NCj4gPiAtLQ0KPiA+IDIuMTcuMQ0K
