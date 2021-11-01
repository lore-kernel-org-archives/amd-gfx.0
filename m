Return-Path: <SRS0=Z8rF=PU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6EDC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 21:42:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27CC360ED3
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 21:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 27CC360ED3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B38B36E029;
	Mon,  1 Nov 2021 21:42:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60D856E029
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Nov 2021 21:42:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkMH3EI7uoHn7homVYJkiYWFksmpUzLcNpCqIMgturEH2I5b5thAxD7ooTER7AewtusBLhWN1+eoJ7+NR9IKfm9LTDSb1A2dLR6lRGTIqtUWeYCIVIkGluSm8Rz9ICDNvyOe2ZeUHOkri1dW9a+Q4KDWxWaCs7HdX4yOSwZfT7ZDFlzZqsNQ4V3MBQ/DgbktRPKHAN8zZkLjCtUQkPH/F3Z1C6sN0Oo8Y583RcxpmrCaAfSpESl2nMpOFPyE/+YFlUvHwmea+5MGVnLvT3Kre5C63eJfxyomqSYd+FlUOx5FH6fFRfi/PGkvW2wSlqcff1uHLA/H2XJm9qzljo9JXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEVUr9N4ZKlI9gHMyPWfVEJj//2u6O2ia5aIQmt5yyM=;
 b=mi2DsbkoCQp/HN342ZBormofvwHKM7QQdIxB56pCp6nndPanuP1mksvLyXT0QZgIa4fK7SjgXb9N1us9NNWIT1mjylcucGdZUzROpeBZS07IpssjFlxqnXSIXTV/jKEmwnPwYotzF96mE8khH8heU/fG13m9ExMitZIVCr9/O0hRUtjVy80x1mygYoTNlLAuciklb7edboXl1oj3SdFp+jwLg0lj9vDCI9PwSxSdZ+x6lY/Fhw1Yxb3CL9bYVcsIjHK7ZZTFkfGsA5yZnUmFTkT+jGdErK0LnZtKC7cL7rbPT3pIF9bC0bQ2EmDyg+wg4LhXO24D7NSriVJ4GkKfLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEVUr9N4ZKlI9gHMyPWfVEJj//2u6O2ia5aIQmt5yyM=;
 b=pmgcVZQn7qxRRB+fnxmr5p57OK8IIN/jbUIj1Nc2pAON6xsMXSpS5fXg4aStz2vAPBR9AT2Ipoewk/pE2El9C0Jjc73VNVCixlzmHwW3D2CactMEaAV4N8p3NatlHGvP1VnMN+5cML5uyYKyLEsetcvYlwdMbXNITXnY6zfTmRA=
Received: from DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26)
 by DM6PR12MB3947.namprd12.prod.outlook.com (2603:10b6:5:148::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 21:42:02 +0000
Received: from DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::40cf:e859:88c4:9b5e]) by DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::40cf:e859:88c4:9b5e%7]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 21:42:02 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Make sure to reserve BOs before adding or
 removing
Thread-Topic: [PATCH] drm/amdgpu: Make sure to reserve BOs before adding or
 removing
Thread-Index: AQHXz10XqtQrezqBV0u30PLjR0oh6avvHFiAgAAG9gCAAA6RoA==
Date: Mon, 1 Nov 2021 21:42:02 +0000
Message-ID: <DM6PR12MB3324A52143123BB6B195C2DA858A9@DM6PR12MB3324.namprd12.prod.outlook.com>
References: <20211101201421.1689492-1-kent.russell@amd.com>
 <b3975b84-6dbb-bdac-2e3f-63f868754b02@amd.com>
 <SA0PR12MB43998918B431C47777886AEAE38A9@SA0PR12MB4399.namprd12.prod.outlook.com>
In-Reply-To: <SA0PR12MB43998918B431C47777886AEAE38A9@SA0PR12MB4399.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-01T21:41:58Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=38d6a4cd-22ed-45de-8a0e-af698344d87e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 114eb1a0-7a39-4e74-68f0-08d99d8070da
x-ms-traffictypediagnostic: DM6PR12MB3947:
x-microsoft-antispam-prvs: <DM6PR12MB39470CD9025AB1ECC0746238858A9@DM6PR12MB3947.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YLfUdQF4hVCl4Ztos/ip9YWtLOj9uV8wr/to3W4FhmUaSvyI4eD/fZtZ4FDHMVPIi08LJ88etkGOnnVk1OG1t+w/N8Ui3rGUhUWPqu3gp+49acxNmr90mxFFUqUJtHEN4FHw2xzmKU/3AchQbinoTvIJdhLoXDcfwP0o8EzJ1QNP0ptKsYL65cAubWyuS/Ma7nKxjgQE80CGehA3Ls3y9ZcJqOuof+yx3qxTbHYB4bRodV7slB1hzyvwiu9GN4TX+hVBJg6EWZmxGl/wLvEL1fID+DcUWcyOJvohgY3K+TNncmT5hMk3L6zIH9Yig3EyjqbsOp15nSndZK1BnQQzp21oOObHFVxFHWd8mqP8iS+jK6I12kw7th9SBHDb55GNPuBisf+UQ9wnm54dnS1o9LfVsoyi8mBY2wWoebiyyu2rQmzKuCOBuCngjepHWGjtRY4q5GryDMqLxUJzTuJ9QIm/uFrqAEU6fgHu6ZJdtQrkDiovjMMW8Z/ZdkrfzXEo+E6xF2T+cdUeEsPquKEBCiYa/1QYuIpCZhxaqFi8CnQYuJXHTKGcgAntedNyoNNetu5gg21PlMPz6XYJRHdBOa+VV2EVeYUmjw9i5eUKeaQPHWRjx3y1rjlSkEDF3fKYSBjaUy9H9h5/8NR8o3pC6YWvcfwBlHY0QeYl3yEVqenPnTQOq/mCmUGF8P+qSk4CCqgRv+fxTxkqBaoyvNyEDg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(5660300002)(508600001)(52536014)(2906002)(66946007)(64756008)(86362001)(8676002)(6506007)(33656002)(53546011)(66476007)(8936002)(55016002)(66556008)(110136005)(38100700002)(122000001)(76116006)(38070700005)(83380400001)(71200400001)(7696005)(9686003)(316002)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2haYkhiSUM2TEZCblkyOG5WaFdLb0hCYUZaUUQ4bXFjS2l3NHIrdll4RzNW?=
 =?utf-8?B?KzM3WTFLL1kxRUEwVnY1WFpjTmhuTFpkVy9PTXVod251SmtxRVZyOGh2bWpO?=
 =?utf-8?B?YmpvbHhJMWJVTTBqYzN2Szk5VUJ4STBmZXc0NVpKS1Jla3VjSW90a1o0cXdy?=
 =?utf-8?B?NnN4QmFOSUU1WVR2bk53bDk3aWtNeUNMb29FSVNjU2tKdEhPZ1lvYlBqZ0JK?=
 =?utf-8?B?WHBMMGtqOTQ1bU9vcG43SmpUeGV5VkF2N1ZQaVR3SUl3UE1YSUF4UkFHdytQ?=
 =?utf-8?B?dXRXVXpvS1crazRoZnZ2bU5iY2hRZ1IweDVSTUZEcTJKdWljdUhUdm5XMGFt?=
 =?utf-8?B?Zjh1M1cxNy9xYW9qMUJCZEFkdW9EcXVnc1d4R0NFd2kyZlRsLzJPTjZaUEx0?=
 =?utf-8?B?L3crVUtYMm5Wd1Y1Q3lGa2VwMnJRK0hBNldBVklSdnBJNXdHOFpseWhJZ1NQ?=
 =?utf-8?B?WTNhR3dSTmJSQUk5eUtORXAzOEV0NVo2a1ZJZnJvdnRvOWx6SDBCaGxEWjc1?=
 =?utf-8?B?OWpTVVhQVk9ZTmZZUm4wejJlRDJlSHI1ZHNBZHB4U3FkSngwWmtaU0dSa3Yr?=
 =?utf-8?B?MTlRRWRnNzFxbzd5WnpST0VHRk5FWm5NeHVUUTA0TithUmdIaDJQY01MeC9G?=
 =?utf-8?B?bGpxc3AxQWtjVzlJMU1iNXY3aEhHaEY4a1ZxV2FQQ2xnR0pBQ1JqdENmQ0l3?=
 =?utf-8?B?aGplSDRXbldKeHNHa1Q1Q3d2R0xFbDlNMnZRc0RHb3NPUGtQMEVQeE03bEU0?=
 =?utf-8?B?M3dqcnAwNENXQXJZbk1CU3BjL1JFamxoMThIV21EOFVDTWVXTzR4RjRTdDdo?=
 =?utf-8?B?ZUVlNDhhenFyWXAzc0x3RU83UnFzTElrSE5uc0VUMjM0ekpnVGpwYkNaVjZh?=
 =?utf-8?B?L1ptNWdwMWVkd2t0L3FSK2gzUGZZbGdXUzN5eWVIZGxSYTBMTUZQUXJiVXli?=
 =?utf-8?B?TjdMYUpEcERWbHhWR3hlNHNwdmkyWFo1ZVZILzBBc2d4Y2JWMDBlNjdQd252?=
 =?utf-8?B?ZWJUQUVOVHFsMEVPM1UzY3NCd29Da2M3K0hOcFE1dnIrdFQ0Q3dSZGxqRlNH?=
 =?utf-8?B?TWVvcGt3WUFYbGM1T1VtUUFpZEJlK2FFeVBSL05GcHpHbmVkYlN3ckdDcU02?=
 =?utf-8?B?ZEpaS3pHYzlFL05yLzc4TUhIMURlNVlZWG40R3FsVjlxYS9SZ0FyeEFTNFRX?=
 =?utf-8?B?SkY2WHJmSzhieWZxWEZ0aU1sV3U3bWRWWnRNbTJrUUQ3blZPR0lKdUswbXFq?=
 =?utf-8?B?bVhpcXQ5Kzl1VDNSMmk5S29YMVhrRHcwSTRkZlU0TjJldzAxT1RvOHA4bHVk?=
 =?utf-8?B?ZERvOFRpNTFpL0Q0RGZCbE1wVUQrdVg0bk9wdXBTUHE2UCtQSytSMUUvalBr?=
 =?utf-8?B?QnVYYXE1eHlDTzRnYzN0SnhYSDhtcm9wVy82SkQrUGRSd0VENHA2NFp5RWhj?=
 =?utf-8?B?Mlg3aHFtUDNGSkdBTzIrb0lzdHZvUWhXUXB0ckVQQVdKOFBZWXdzZW5UK3dk?=
 =?utf-8?B?NnpRa3pEU2ViakJoa0NLUENldEpMT2xFMzBqaDdoNTFXWnU2WXU2Rnl1VVpZ?=
 =?utf-8?B?SUg3U0ppTVN3REpSblZtTGV2TmdLM0crUDYzc0V4cmV6WUxEYVd4ZUZsSTVL?=
 =?utf-8?B?RE53alZKZWdqVGU4U0Vkc2s3ZzYxdi9CQ2RmVEJVQkZPRnRDV2FBdytEUVRy?=
 =?utf-8?B?NUsxTHQyQkxqWWF1bzFRcDAra3FrVE8wRy9qN0MxZkRWdzJLalFKNisvOUN3?=
 =?utf-8?B?VHNrYitqUnZkMUpSSlhvMjhSa3FuS1QyWUVJclpUdUI3NzI3bTZMRE5GdzZm?=
 =?utf-8?B?MVNLUVhJUjFvTnNkMEtxUWt1eEtnclM0eE90b2k5cElOZkFGZVpjbCtSVmwv?=
 =?utf-8?B?Y1dFeEgwWEhBdk4yWmxWTnRldExmQmRzVkloZHlxZlY2NHpCQzY1a0ltdjhV?=
 =?utf-8?B?WFl2QTlVa3plRmZ5eFBsYSt5UTRCbDI3ZWp4Y1RJU1F4RmRucGdPeUNhbTVj?=
 =?utf-8?B?eU13RTI0TXJPOEIrbFJQS1h6ZHNMUjl0dmV0Q3JJclFmbTFFTDhSUkI1emxB?=
 =?utf-8?B?S3ZsaVVqVlg1SjdheXJnOTIyTnJwQ0txRGFLdWdzMkQ4TmJ1MEpUK1R1SERa?=
 =?utf-8?B?UWxNVW5COUpIaWVvdlpxTFBRRDBYa09TQW1QMzBIUUhqUkFoYzh1aCt6cWd4?=
 =?utf-8?B?L0EwMVhqdFhFZ2NNMW51NGZkSFdnRkVIYjBUekJTYXQzMnhHYkdscDY3SVdY?=
 =?utf-8?Q?pAIZcFaVFGEYoFiePllLZ/ZRUpFsl01N5HnnS2ajY0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 114eb1a0-7a39-4e74-68f0-08d99d8070da
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2021 21:42:02.3173 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: snzjCszmLqv6w2SQBi0cBZjY+EJ48+4aqmGI54FEQig4DbV4sBEKCchY3XJ3ndTVXrWsENedKN98ejg4L6606w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3947
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgUmFtZXNoLA0KDQprZmRfbWVtX2F0dGFjaF9k
bWFidWYgd291bGQgZGVhZGxvY2sgaWYgdGhlIEJPIGlzIGFscmVhZHkgcmVzZXJ2ZWQsIHdoaWNo
IGlzIG9idmlvdXNseSBwcm9ibGVtYXRpYy4gDQoNCkFsc28sIGlmIGl0J3MgQVFMLCB3ZSBtYWtl
IDIgQk9zLCBhbmQgd291bGQgbmVlZCB0byByZXNlcnZlIGVhY2ggb25lIG9mIHRob3NlIGR1cmlu
ZyBhZGRpdGlvbiwgd2hpY2ggd2UgY2FuJ3QgZWFzaWx5IGRvIGlmIHdlIGxvY2sgb3V0c2lkZSBv
ZiBhdHRhY2guDQoNCiBLZW50DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogRXJyYWJvbHUsIFJhbWVzaCA8UmFtZXNoLkVycmFib2x1QGFtZC5jb20+DQo+IFNlbnQ6IE1v
bmRheSwgTm92ZW1iZXIgMSwgMjAyMSA0OjQzIFBNDQo+IFRvOiBLdWVobGluZywgRmVsaXggPEZl
bGl4Lkt1ZWhsaW5nQGFtZC5jb20+OyBSdXNzZWxsLCBLZW50IDxLZW50LlJ1c3NlbGxAYW1kLmNv
bT47DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJFOiBbUEFU
Q0hdIGRybS9hbWRncHU6IE1ha2Ugc3VyZSB0byByZXNlcnZlIEJPcyBiZWZvcmUgYWRkaW5nIG9y
IHJlbW92aW5nDQo+IA0KPiBLZW50LCB0aGUgY2FsbCB0byBtYXAgaGFzIHRoZSBzYW1lIHN0cnVj
dHVyZS4gSXMgaXQgbm90IHBvc3NpYmxlIHRvIGNhbGwga2ZkX21lbV9hdHRhY2ggYWZ0ZXINCj4g
Qk8ncyBhcmUgcmVzZXJ2ZWQ/DQo+IA0KPiBSZWdhcmRzLA0KPiBSYW1lc2gNCj4gDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0Bs
aXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBGZWxpeCBLdWVobGluZw0KPiBTZW50
OiBNb25kYXksIE5vdmVtYmVyIDEsIDIwMjEgMzoxOCBQTQ0KPiBUbzogUnVzc2VsbCwgS2VudCA8
S2VudC5SdXNzZWxsQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBNYWtlIHN1cmUgdG8gcmVzZXJ2ZSBCT3Mg
YmVmb3JlIGFkZGluZyBvciByZW1vdmluZw0KPiANCj4gW0NBVVRJT046IEV4dGVybmFsIEVtYWls
XQ0KPiANCj4gQW0gMjAyMS0xMS0wMSB1bSA0OjE0IHAubS4gc2NocmllYiBLZW50IFJ1c3NlbGw6
DQo+ID4gQk9zIG5lZWQgdG8gYmUgcmVzZXJ2ZWQgYmVmb3JlIHRoZXkgYXJlIGFkZGVkIG9yIHJl
bW92ZWQsIHNvIGVuc3VyZQ0KPiA+IHRoYXQgdGhleSBhcmUgcmVzZXJ2ZWQgZHVyaW5nIGtmZF9t
ZW1fYXR0YWNoIGFuZCBrZmRfbWVtX2RldGFjaA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2Vu
dCBSdXNzZWxsIDxrZW50LnJ1c3NlbGxAYW1kLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBGZWxp
eCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj4gDQo+IA0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMgfCAxMyAr
KysrKysrKysrLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+ID4gaW5kZXggNjE3ODRiYmZkN2ZkLi44ZDMwY2Nk
NzA4MDAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2FtZGtmZF9ncHV2bS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2FtZGtmZF9ncHV2bS5jDQo+ID4gQEAgLTc5OCwxNCArNzk4LDE5IEBAIHN0YXRpYyBpbnQg
a2ZkX21lbV9hdHRhY2goc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdA0KPiBrZ2Rf
bWVtICptZW0sDQo+ID4gICAgICAgICAgICAgICB9DQo+ID4NCj4gPiAgICAgICAgICAgICAgIC8q
IEFkZCBCTyB0byBWTSBpbnRlcm5hbCBkYXRhIHN0cnVjdHVyZXMgKi8NCj4gPiArICAgICAgICAg
ICAgIHJldCA9IGFtZGdwdV9ib19yZXNlcnZlKGJvW2ldLCBmYWxzZSk7DQo+ID4gKyAgICAgICAg
ICAgICBpZiAocmV0KSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHByX2RlYnVnKCJVbmFi
bGUgdG8gcmVzZXJ2ZSBCTyBkdXJpbmcgbWVtb3J5IGF0dGFjaCIpOw0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICBnb3RvIHVud2luZDsNCj4gPiArICAgICAgICAgICAgIH0NCj4gPiAgICAgICAg
ICAgICAgIGF0dGFjaG1lbnRbaV0tPmJvX3ZhID0gYW1kZ3B1X3ZtX2JvX2FkZChhZGV2LCB2bSwN
Cj4gPiBib1tpXSk7DQo+ID4gKyAgICAgICAgICAgICBhbWRncHVfYm9fdW5yZXNlcnZlKGJvW2ld
KTsNCj4gPiAgICAgICAgICAgICAgIGlmICh1bmxpa2VseSghYXR0YWNobWVudFtpXS0+Ym9fdmEp
KSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIHJldCA9IC1FTk9NRU07DQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgIHByX2VycigiRmFpbGVkIHRvIGFkZCBCTyBvYmplY3QgdG8gVk0uIHJl
dCA9PSAlZFxuIiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldCk7DQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgIGdvdG8gdW53aW5kOw0KPiA+ICAgICAgICAgICAgICAgfQ0K
PiA+IC0NCj4gPiAgICAgICAgICAgICAgIGF0dGFjaG1lbnRbaV0tPnZhID0gdmE7DQo+ID4gICAg
ICAgICAgICAgICBhdHRhY2htZW50W2ldLT5wdGVfZmxhZ3MgPSBnZXRfcHRlX2ZsYWdzKGFkZXYs
IG1lbSk7DQo+ID4gICAgICAgICAgICAgICBhdHRhY2htZW50W2ldLT5hZGV2ID0gYWRldjsgQEAg
LTgyMSw3ICs4MjYsOSBAQCBzdGF0aWMNCj4gPiBpbnQga2ZkX21lbV9hdHRhY2goc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBrZ2RfbWVtICptZW0sDQo+ID4gICAgICAgICAgICAg
ICBpZiAoIWF0dGFjaG1lbnRbaV0pDQo+ID4gICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVl
Ow0KPiA+ICAgICAgICAgICAgICAgaWYgKGF0dGFjaG1lbnRbaV0tPmJvX3ZhKSB7DQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgIGFtZGdwdV9ib19yZXNlcnZlKGJvW2ldLCB0cnVlKTsNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgYW1kZ3B1X3ZtX2JvX3JtdihhZGV2LCBhdHRhY2htZW50W2ld
LT5ib192YSk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGFtZGdwdV9ib191bnJlc2VydmUo
Ym9baV0pOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBsaXN0X2RlbCgmYXR0YWNobWVudFtp
XS0+bGlzdCk7DQo+ID4gICAgICAgICAgICAgICB9DQo+ID4gICAgICAgICAgICAgICBpZiAoYm9b
aV0pDQo+ID4gQEAgLTE3MDAsMTIgKzE3MDcsMTIgQEAgaW50IGFtZGdwdV9hbWRrZmRfZ3B1dm1f
ZnJlZV9tZW1vcnlfb2ZfZ3B1KA0KPiA+ICAgICAgIHByX2RlYnVnKCJSZWxlYXNlIFZBIDB4JWxs
eCAtIDB4JWxseFxuIiwgbWVtLT52YSwNCj4gPiAgICAgICAgICAgICAgIG1lbS0+dmEgKyBib19z
aXplICogKDEgKyBtZW0tPmFxbF9xdWV1ZSkpOw0KPiA+DQo+ID4gLSAgICAgcmV0ID0gdW5yZXNl
cnZlX2JvX2FuZF92bXMoJmN0eCwgZmFsc2UsIGZhbHNlKTsNCj4gPiAtDQo+ID4gICAgICAgLyog
UmVtb3ZlIGZyb20gVk0gaW50ZXJuYWwgZGF0YSBzdHJ1Y3R1cmVzICovDQo+ID4gICAgICAgbGlz
dF9mb3JfZWFjaF9lbnRyeV9zYWZlKGVudHJ5LCB0bXAsICZtZW0tPmF0dGFjaG1lbnRzLCBsaXN0
KQ0KPiA+ICAgICAgICAgICAgICAga2ZkX21lbV9kZXRhY2goZW50cnkpOw0KPiA+DQo+ID4gKyAg
ICAgcmV0ID0gdW5yZXNlcnZlX2JvX2FuZF92bXMoJmN0eCwgZmFsc2UsIGZhbHNlKTsNCj4gPiAr
DQo+ID4gICAgICAgLyogRnJlZSB0aGUgc3luYyBvYmplY3QgKi8NCj4gPiAgICAgICBhbWRncHVf
c3luY19mcmVlKCZtZW0tPnN5bmMpOw0KPiA+DQo=
