Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0398EC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 07:15:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57E3E10FB6B;
	Wed, 25 May 2022 07:15:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B812610FB6B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 07:15:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWZKRY4hku+OGdfhzgBHzPOSWf2q9CW7WqT3L7NhRrCKU8zZEfgxmTsk76iA5wGEah6tfc1Bvx0lMJeReTtn4jMCSebjPCTfFPVverU10w3IRyn5ZenOXSOvPQ12LOvq268r8dkUBHBHxJftNKjyNKFPOv3qRBb4lz0muY27cCTnvmppv1T1PYBOHppCPS6uL2+FqSX+5oSIu+9zvFjcJfHMswmWi2abmoAWeU5TwrgenV4hNG6C8EoPUZOH2IzT7q9dGJRPkrGyce2IaNIr0cTghnsP8tLFv9tuoOWn2DWu4hmAU7WYyYRsbUyLvzyHuEztMg53zaLjmspXWKGtGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ESQO35zdHkvSiwzkBo0lpfNPUU4vMqaxvYdzXQpdAA=;
 b=oZQKJOLNQEYU/bh8cf3hSFPzj10HpRuSFH8CKrzmGTiN3ZpF+9TW5iJAVB+lhk8RbyVsx0ZQZHDf53rKodvhn0Orn0dURtZKvQP8S10BAMO0VcC2pr4TLtgOfx3KjKHNKdmqxFwFFmWk+s+iT/6DQ6Uqo31jbXV5gPsByhppUlSWyVF4GWgkTsPwM37X52BM6ckLsit0N+W9N328mgbpy21e2NuowLDDogx/ROtjU3jhUCOHDcawyrixHkY9XqcSWmCtmLTt1FjgQlT6nKfYhrBf8Zdb2mhXFxFiMwfaeen5wj/vooFzqsCIF1vFtS/pgCZ3VfhBvVs4yXbmmzG1mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ESQO35zdHkvSiwzkBo0lpfNPUU4vMqaxvYdzXQpdAA=;
 b=mHxm/H7tNA90qeU9OX4quj12k7feaMhKO/5gC+oTkliWVIU3e6MK7ywVdAQ7mZT2SDjoZTCjdpCSlDdasCa3oKA1xeLnLPWu6q9NZb4MQaG7Pu8D6BAIhdQeG/v0GcZroln0236LldMQjiZbAnuboNB54cS9wDVPmiMHSM0RDmM=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by BL3PR12MB6641.namprd12.prod.outlook.com (2603:10b6:208:38d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 25 May
 2022 07:15:07 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::d504:b18d:6b58:cf8d]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::d504:b18d:6b58:cf8d%5]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 07:15:07 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIFJldmlldyB2MyAyLzJdIGRybS9hbWRncHU6IHByaW50?=
 =?gb2312?Q?_umc_correctable_error_address?=
Thread-Topic: [PATCH Review v3 2/2] drm/amdgpu: print umc correctable error
 address
Thread-Index: AQHYb/40K2NUEuNeckG/IUAH7kY+aa0vJ+KAgAAEZag=
Date: Wed, 25 May 2022 07:15:07 +0000
Message-ID: <BL1PR12MB533450EE99DEF72669FAC0E39AD69@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20220525061047.26529-1-Stanley.Yang@amd.com>
 <20220525061047.26529-2-Stanley.Yang@amd.com>
 <CO6PR12MB5473A51D94BF334E70E5353482D69@CO6PR12MB5473.namprd12.prod.outlook.com>
In-Reply-To: <CO6PR12MB5473A51D94BF334E70E5353482D69@CO6PR12MB5473.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-25T06:51:59.7880000Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22535c47-f599-4f1c-878c-08da3e1e4bf9
x-ms-traffictypediagnostic: BL3PR12MB6641:EE_
x-microsoft-antispam-prvs: <BL3PR12MB6641CF6E69842980B07FCBC39AD69@BL3PR12MB6641.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T/MfiSbJVB0yIOz3HRUlHYXBgm0HbBV3QuCJX5+8vSurTd0K5tnpXpO2WqIKh6daIbHZoyjp5CFw6TfVqh42MABIm4QHo+5zvKX/3CFuC3yvlLnkzg1mnEwTVRaHhZ2BC+FSZVaRldG8z5j4G7L1exBP4MtTkfhNNld/vPAV0llkT4B9GnHuSETpzUmlenjcYqAIBjZp6wUmXtqSTZxqDK6NDS1qK3b5JVjMtoBbxyM5BJ+oX3S++Gb4c0QHi16R7sSfZVIoNr4JM/caI/mEDuPTovxJDoRvZyIIzvHEyJ9MbnAVmk8NPRBfduHCoOIswR/r1MnlR0WOzpsS5vHfDMeN+dZPQk1zq/SODMnCy5/ET8R1lvpLQP7hFzfy5/TuonWOsrZ8iGk/Knr7nikbU7xmWyUVlH9wx/5P1aWE1qw7yQjp9fR81Qsu1tloqAtvfIp4VGQTwES1RnKuBXo/EjIxgVxK/f0PTf0sLGaMudBA1xfXxxGUMCYq/Ozc/8/dCDcgJ1vGgIhTcK8nGquPMy98vm5h2E+Lne40V0us5mH3miN7i59CiUDqeSxMV+2sQJP6Za2VtNX/W61o0uL/7F+cXqJM3RtN4r4rs7M5hjpTAX/Hfmrjn31Zx883FsbYYG5FB9QjuW/9Lx2S2AgsEPFIzjaUTgNpgHBwtN9x3nBJF8kgbvSlic7td7GpE0EQD2r5kSL/sFjQJaj+hbrHOht/YCe1gW2LZhwBruLxK4A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(7696005)(55016003)(122000001)(83380400001)(52536014)(921005)(186003)(8936002)(6506007)(508600001)(5660300002)(38070700005)(38100700002)(66556008)(66946007)(76116006)(91956017)(86362001)(66476007)(224303003)(6636002)(66446008)(9686003)(64756008)(110136005)(316002)(71200400001)(53546011)(33656002)(2906002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TlNHSTBuWklIM3R1SGpqanF6d0JWYStkblNUZVBYNW1IU1d2eWdLR0I5Mnhl?=
 =?gb2312?B?ZnR1NFFVVzZtT0hiTDhETkNlT1hFTWlvd21PNjVad1dXU2ViS2RRNWRuRFEv?=
 =?gb2312?B?SlEyc0xBVUppWk9sTnJVUzVlRkhUWTdqelNJd0hIYVU3ejR6Vi8zcno0TDJk?=
 =?gb2312?B?dDhZSGhDeFAvL05lMW1xeWdoV1FTcEk5KzVDQk5rMkVacWUzRFNWU0Nod1FW?=
 =?gb2312?B?UU90aENNMFhXQWdVSkVwU2dmanRmdFRFc3RlRWIwWDdCYjVoSVJvVlo0YjNC?=
 =?gb2312?B?VXhIYWZIY1hQb2xQeS94eFlGNnJqbnYxd2ZpZFMvVXk1TDUrSUQvRktXQmRC?=
 =?gb2312?B?dDNISklQZE1lbGR0dWs3aFZmUEMzUmxkQ3oxVHl5YXZQSXFzSlNJSUJRbmI2?=
 =?gb2312?B?dmhPS1MrUGlKc3lNVCtrRkFkUTJ5amNYa3RhWWlzMmlydnR0cXNneXFzcElZ?=
 =?gb2312?B?aG5zbThwakJLYjROM3NPRUtCWG1FRUN1VWRGYmJoTzdOdE1wWVQ1MkkvMG10?=
 =?gb2312?B?UEV3cHZVaEVLeUI1WGVYZzh6RGMzcitqVzNwWUdlWGk3Y2hnZmU4YUE3V00v?=
 =?gb2312?B?RUlYNXV5ZGo5NTFpalViekZkbGtuY2lFWVc3TUp3N0dPcjBJZEh4ck9UU1dn?=
 =?gb2312?B?aUlDYXlodGZ5bUN0VnJvaFNueUhwcmw0ckQ3VngrRWY4MHJ1MEg2QjZtd1pz?=
 =?gb2312?B?YlBHRUFCN1lFa3dBMjRpbUJLbkR5ZjF3elJIdTMwNTMxTlNiRXNKekpFRU5M?=
 =?gb2312?B?OEJ1N09YK1lpWUVCdEpaMzUrUEoxTUJvd0YzaktvcWJxOStQNnkvNm4rQ3pU?=
 =?gb2312?B?bllOQ0RtbGlrdW81M1czeDRra0prNlRHM0lVWk1QNmw2OHNRbXJZdHhKWElE?=
 =?gb2312?B?OWNvS3crb2tIcFlYNXpXRnk5cjdqWnM5cHBGcDhOZG9aQW5FMWhEVkpWQWl6?=
 =?gb2312?B?LyttaEloSWE4VFdrV3lwaGdlNUhWdVhwcnhjeTRHT2dWV1ZEelNCSGo4TytW?=
 =?gb2312?B?UFJJZGJEc2xFVC9IekxoQzFXaWU2TzFURGNsZ0RINmkrSDg5OGM5R3c2aUJP?=
 =?gb2312?B?bEszYXQ0bkVsTGc3ZzJOQUdXTnFSVXdpM0o5cW5iam9xUHlGclZTMnFJQlo1?=
 =?gb2312?B?aGZNVml5eFEvOXBXcjJtUFhhQ1MyeHdzaVI4elBHeHdRWUo4WWtQWU9ycm1I?=
 =?gb2312?B?bHZWNmdXdjY4eGxibmNYd2I4RTFTVlJ1b3JHRXM0VTAzYld6dUlKckNOeTFl?=
 =?gb2312?B?VHFHSVhqVUwrNGEvOG5ZK2lEb0ZubW4zSkFkQm45Und4SkoraVpZTnI5d0NQ?=
 =?gb2312?B?M1Bzb3JPamp0OVJmcmpHWStkOGd5WXFvaUNVNzNEZ1VvWjE2OTNmV05mOHYw?=
 =?gb2312?B?Nzd0cy9tcklhcjVTY0tnRW1GMFJ6S041VSt5RW40MXJ0VDMyYzR6dEs0eHpn?=
 =?gb2312?B?VVNCdTVMWnlVWXZRWTdFWmVqT0NndU9Ga3pxcVpHZm1ZaW5lNDV2NStPcFYw?=
 =?gb2312?B?K2RDOVJzUzdWdU91SFptYk5yaldPVFZKQWF1eGJneXVtVEVrbDRYVTY2WStn?=
 =?gb2312?B?S3VldXVORENQQlU0RFk4aWJma0lmUUNYMmhDaVFIbGZJN3M1L0JzRVJpbnIv?=
 =?gb2312?B?WC9RRXh2eC9jNDdIVzlJek02RTViSk5Hd0J0NWQzQ1VLKzc5VUgyLyt2UkJD?=
 =?gb2312?B?TE9yMmpCY3dJUDZhNjJPRVE1aDVIcVlPVm5kWU5UdHUyQ0lPakpOUkJCUUJk?=
 =?gb2312?B?UloydGlVTTJ5Uzljd1ZqWWJrZWdDRWNFa3dUdkpEWWw0RDdUbENCSWt0cjZ1?=
 =?gb2312?B?QVppcjdiVUtHMi92Y09veXlWbGF1UUhwMnZraGpGMXNhKzBiVWU4M0llT1FU?=
 =?gb2312?B?MEZLS0tVcjk1WHQxYVhSamtiVkQvSld2TzJRL0V4Ym1zRlBycDNhMzd6cnVw?=
 =?gb2312?B?OHNZempaZk82OWdYT1kwT3pxRExtL0dLY1N6djJCSDZQUTlleUJOUUNDd1Q3?=
 =?gb2312?B?dTRaUjB0dHRocDUrMjB5T2tDL0QwK041VTBnekh6UDFja202dWZ3TGlCaWxk?=
 =?gb2312?B?bEJNc2F6M1loSG94Sk1vM3M4aDNIMnRoYnFHdXhyUmdLdSttcTRkUGRXZ0l2?=
 =?gb2312?B?Z0ovTDZ6QXJ6VXF5TVF1dW4xbzlnY0RJSnhONWJkZGJTS09nVDViWWJVYjBs?=
 =?gb2312?B?VnRlcWlTR1ZCWG8zQUNnL2ljT20vQ3JKOCtZS1dlcjJDTHFUUE9qS21hR05Q?=
 =?gb2312?B?ekxiNXpaRmxGU2tXNExKMkVKcy9LcERJTk5GZGE2ZThqaGZoQ0RZaVc5MTVD?=
 =?gb2312?B?OGpHclhia0cvNm95VGZwWnBWWUdLRjgzb0VQUGNhbjNhMGtzTXh2aTNOSTA5?=
 =?gb2312?Q?p/6HOkhlR0DE1Fn0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB533450EE99DEF72669FAC0E39AD69BL1PR12MB5334namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22535c47-f599-4f1c-878c-08da3e1e4bf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 07:15:07.0776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rxIwothJSgHc7daTBufSJK+MSIJ6q7eUxDI2DfcYXBPTADcN8McDNeGPiJxpwfCx1scuBT9DMNchVb+ftOzvwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6641
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

--_000_BL1PR12MB533450EE99DEF72669FAC0E39AD69BL1PR12MB5334namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KW0FNRCBPZmZpY2lhbCBVc2Ug
T25seSAtIEdlbmVyYWxdDQoNCg0Kt6K8/sjLOiBXYW5nLCBZYW5nKEtldmluKSA8S2V2aW5ZYW5n
LldhbmdAYW1kLmNvbT4NCsjVxto6INDHxtrI/SwgMjAyMsTqNdTCMjXI1SDPws7nMjo1Mg0KytW8
/sjLOiBZYW5nLCBTdGFubGV5IDxTdGFubGV5LllhbmdAYW1kLmNvbT4sIGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnIDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4sIFpoYW5nLCBI
YXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+LCBaaG91MSwgVGFvIDxUYW8uWmhvdTFAYW1k
LmNvbT4sIFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPiwgTGF6YXIsIExpam8gPExpam8u
TGF6YXJAYW1kLmNvbT4NCtb3zOI6IFJlOiBbUEFUQ0ggUmV2aWV3IHYzIDIvMl0gZHJtL2FtZGdw
dTogcHJpbnQgdW1jIGNvcnJlY3RhYmxlIGVycm9yIGFkZHJlc3MNCg0KW0FNRCBPZmZpY2lhbCBV
c2UgT25seSAtIEdlbmVyYWxdDQoNCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0
cy5mcmVlZGVza3RvcC5vcmc+IG9uIGJlaGFsZiBvZiBTdGFubGV5LllhbmcgPFN0YW5sZXkuWWFu
Z0BhbWQuY29tPg0KU2VudDogV2VkbmVzZGF5LCBNYXkgMjUsIDIwMjIgMjoxMCBQTQ0KVG86IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zz47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBaaG91MSwgVGFvIDxU
YW8uWmhvdTFAYW1kLmNvbT47IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPjsgTGF6YXIs
IExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCkNjOiBZYW5nLCBTdGFubGV5IDxTdGFubGV5Lllh
bmdAYW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSCBSZXZpZXcgdjMgMi8yXSBkcm0vYW1kZ3B1OiBw
cmludCB1bWMgY29ycmVjdGFibGUgZXJyb3IgYWRkcmVzcw0KDQpDaGFuZ2VkIGZyb20gVjE6DQog
ICAgICAgIHJlbW92ZSB1bm5lY2Vzc2FyeSBzYW1lIHJvdyBwaHlzaWNhbCBhZGRyZXNzIGNhbGN1
bGF0aW9uDQoNCkNoYW5nZWQgZnJvbSBWMjoNCiAgICAgICAgbW92ZSByZWNvcmRfY2VfYWRkcl9z
dXBwb3J0ZWQgdG8gdW1jX2VjY19pbmZvIHN0cnVjdA0KDQpTaWduZWQtb2ZmLWJ5OiBTdGFubGV5
LllhbmcgPFN0YW5sZXkuWWFuZ0BhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Jhcy5oICAgICAgIHwgIDUgKysNCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS91bWNfdjZfNy5jICAgICAgICAgfCA1MCArKysrKysrKysrKysrKysrKystDQogLi4uL2Ry
bS9hbWQvcG0vc3dzbXUvc211MTMvYWxkZWJhcmFuX3BwdC5jICAgIHwgIDEgKw0KIDMgZmlsZXMg
Y2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuaCBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuaA0KaW5kZXggMjhlNjAzMjQzYjY3Li5iZjVhOTUxMDRl
YzEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmgN
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuaA0KQEAgLTMzMyw2
ICszMzMsMTEgQEAgc3RydWN0IGVjY19pbmZvX3Blcl9jaCB7DQoNCiBzdHJ1Y3QgdW1jX2VjY19p
bmZvIHsNCiAgICAgICAgIHN0cnVjdCBlY2NfaW5mb19wZXJfY2ggZWNjW01BWF9VTUNfQ0hBTk5F
TF9OVU1dOw0KKw0KKyAgICAgICAvKiBEZXRlcm1pbmUgc211IGVjY3RhYmxlIHdoZXRoZXIgc3Vw
cG9ydA0KKyAgICAgICAgKiByZWNvcmQgY29ycmVjdGFibGUgZXJyb3IgYWRkcmVzcw0KKyAgICAg
ICAgKi8NCisgICAgICAgaW50IHJlY29yZF9jZV9hZGRyX3N1cHBvcnRlZDsNCiB9Ow0KDQpba2V2
aW5dOg0KDQogIDEuICB0aGUgbmV3IGZpZWxkIG9mIHJlY29yZF9jZV9hZGRyX3N1cHBvcnRlZCBp
cyBub3Qgc2V0IG9uIHNpZW5uYV9jaWNobGlkIGNoaXAuDQpTdGFubGV5OiBTaWVubmFfY2ljaGls
ZCBub3Qgc3VwcG9ydCB0aGlzIGZlYXR1cmUsIHNvIGRvIG5vdCBzZXQgcmVjb3JkX2NlX2FkZHJf
c3VwcG9ydGVkLg0KDQogIDEuICBhbmQgdGhpcyBmaWVsZCBpcyBiZXR0ZXIgdG8gcmVuYW1lZCB0
byBvdGhlcnMgd2hlbiB0aGlzIGVjYyB0YWJsZShwbWZ3IHNpZGUpIHVwZGF0ZSBhZ2FpbiBpbiB0
aGUgZnVydHVyZS4gLmUuZzogZWNjX3RhYmxlX3ZlcnNpb24NCg0KU3RhbmxleTogVG8gbmFtZSBy
ZWNvcmRfY2VfYWRkcl9zdXBwb3J0ZWQgaXMgbW9yZSBpbnR1aXRpdmUgdGhlbiB1c2luZyBlY2Nf
dGFibGVfdmVyc2lvbiBvciBvdGhlcnMuDQoNCkJlc3QgUmVnYXJkcw0KS2V2aW4NCg0KIHN0cnVj
dCBhbWRncHVfcmFzIHsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91
bWNfdjZfNy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdW1jX3Y2XzcuYw0KaW5kZXgg
NjA2ODkyZGJlYTFjLi5iZjc1MjRmMTZiNjYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS91bWNfdjZfNy5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91
bWNfdjZfNy5jDQpAQCAtMTE5LDYgKzExOSwyNCBAQCBzdGF0aWMgdm9pZCB1bWNfdjZfN19lY2Nf
aW5mb19xdWVyeV9jb3JyZWN0YWJsZV9lcnJvcl9jb3VudChzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0K
ICAgICAgICAgICAgICAgICAqZXJyb3JfY291bnQgKz0gMTsNCg0KICAgICAgICAgICAgICAgICB1
bWNfdjZfN19xdWVyeV9lcnJvcl9zdGF0dXNfaGVscGVyKGFkZXYsIG1jX3VtY19zdGF0dXMsIHVt
Y19yZWdfb2Zmc2V0KTsNCisNCisgICAgICAgICAgICAgICBpZiAocmFzLT51bWNfZWNjLnJlY29y
ZF9jZV9hZGRyX3N1cHBvcnRlZCkgICAgICB7DQorICAgICAgICAgICAgICAgICAgICAgICB1aW50
NjRfdCBlcnJfYWRkciwgc29jX3BhOw0KKyAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3Qg
Y2hhbm5lbF9pbmRleCA9DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPnVt
Yy5jaGFubmVsX2lkeF90YmxbdW1jX2luc3QgKiBhZGV2LT51bWMuY2hhbm5lbF9pbnN0X251bSAr
IGNoX2luc3RdOw0KKw0KKyAgICAgICAgICAgICAgICAgICAgICAgZXJyX2FkZHIgPSByYXMtPnVt
Y19lY2MuZWNjW2VjY2luZm9fdGFibGVfaWR4XS5tY2FfY2V1bWNfYWRkcjsNCisgICAgICAgICAg
ICAgICAgICAgICAgIGVycl9hZGRyID0gUkVHX0dFVF9GSUVMRChlcnJfYWRkciwgTUNBX1VNQ19V
TUMwX01DVU1DX0FERFJUMCwgRXJyb3JBZGRyKTsNCisgICAgICAgICAgICAgICAgICAgICAgIC8q
IHRyYW5zbGF0ZSB1bWMgY2hhbm5lbCBhZGRyZXNzIHRvIHNvYyBwYSwgMyBwYXJ0cyBhcmUgaW5j
bHVkZWQgKi8NCisgICAgICAgICAgICAgICAgICAgICAgIHNvY19wYSA9IEFERFJfT0ZfOEtCX0JM
T0NLKGVycl9hZGRyKSB8DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
QUREUl9PRl8yNTZCX0JMT0NLKGNoYW5uZWxfaW5kZXgpIHwNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBPRkZTRVRfSU5fMjU2Ql9CTE9DSyhlcnJfYWRkcik7DQorDQor
ICAgICAgICAgICAgICAgICAgICAgICAvKiBUaGUgdW1jIGNoYW5uZWwgYml0cyBhcmUgbm90IG9y
aWdpbmFsIHZhbHVlcywgdGhleSBhcmUgaGFzaGVkICovDQorICAgICAgICAgICAgICAgICAgICAg
ICBTRVRfQ0hBTk5FTF9IQVNIKGNoYW5uZWxfaW5kZXgsIHNvY19wYSk7DQorDQorICAgICAgICAg
ICAgICAgICAgICAgICBkZXZfaW5mbyhhZGV2LT5kZXYsICJFcnJvciBBZGRyZXNzKFBBKTogMHgl
bGx4XG4iLCBzb2NfcGEpOw0KKyAgICAgICAgICAgICAgIH0NCiAgICAgICAgIH0NCiB9DQoNCkBA
IC0yNTEsNyArMjY5LDkgQEAgc3RhdGljIHZvaWQgdW1jX3Y2XzdfZWNjX2luZm9fcXVlcnlfcmFz
X2Vycm9yX2FkZHJlc3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYNCg0KIHN0YXRpYyB2b2lk
IHVtY192Nl83X3F1ZXJ5X2NvcnJlY3RhYmxlX2Vycm9yX2NvdW50KHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbnQzMl90IHVtY19yZWdfb2Zmc2V0LA0KLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyAqZXJyb3JfY291bnQpDQor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25l
ZCBsb25nICplcnJvcl9jb3VudCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHVpbnQzMl90IGNoX2luc3QsDQorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCB1bWNfaW5zdCkNCiB7DQogICAg
ICAgICB1aW50MzJfdCBlY2NfZXJyX2NudF9zZWwsIGVjY19lcnJfY250X3NlbF9hZGRyOw0KICAg
ICAgICAgdWludDMyX3QgZWNjX2Vycl9jbnQsIGVjY19lcnJfY250X2FkZHI7DQpAQCAtMjk1LDYg
KzMxNSwzMSBAQCBzdGF0aWMgdm9pZCB1bWNfdjZfN19xdWVyeV9jb3JyZWN0YWJsZV9lcnJvcl9j
b3VudChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCiAgICAgICAgICAgICAgICAgKmVycm9y
X2NvdW50ICs9IDE7DQoNCiAgICAgICAgICAgICAgICAgdW1jX3Y2XzdfcXVlcnlfZXJyb3Jfc3Rh
dHVzX2hlbHBlcihhZGV2LCBtY191bWNfc3RhdHVzLCB1bWNfcmVnX29mZnNldCk7DQorDQorICAg
ICAgICAgICAgICAgew0KKyAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgZXJyX2FkZHIs
IHNvY19wYTsNCisgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IG1jX3VtY19hZGRydDA7
DQorICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBjaGFubmVsX2luZGV4Ow0KKw0KKyAg
ICAgICAgICAgICAgICAgICAgICAgbWNfdW1jX2FkZHJ0MCA9DQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFNPQzE1X1JFR19PRkZTRVQoVU1DLCAwLCByZWdNQ0FfVU1DX1VNQzBfTUNV
TUNfQUREUlQwKTsNCisNCisgICAgICAgICAgICAgICAgICAgICAgIGNoYW5uZWxfaW5kZXggPQ0K
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhZGV2LT51bWMuY2hhbm5lbF9pZHhfdGJs
W3VtY19pbnN0ICogYWRldi0+dW1jLmNoYW5uZWxfaW5zdF9udW0gKyBjaF9pbnN0XTsNCisNCisg
ICAgICAgICAgICAgICAgICAgICAgIGVycl9hZGRyID0gUlJFRzY0X1BDSUUoKG1jX3VtY19hZGRy
dDAgKyB1bWNfcmVnX29mZnNldCkgKiA0KTsNCisgICAgICAgICAgICAgICAgICAgICAgIGVycl9h
ZGRyID0gUkVHX0dFVF9GSUVMRChlcnJfYWRkciwgTUNBX1VNQ19VTUMwX01DVU1DX0FERFJUMCwg
RXJyb3JBZGRyKTsNCisNCisgICAgICAgICAgICAgICAgICAgICAgIC8qIHRyYW5zbGF0ZSB1bWMg
Y2hhbm5lbCBhZGRyZXNzIHRvIHNvYyBwYSwgMyBwYXJ0cyBhcmUgaW5jbHVkZWQgKi8NCisgICAg
ICAgICAgICAgICAgICAgICAgIHNvY19wYSA9IEFERFJfT0ZfOEtCX0JMT0NLKGVycl9hZGRyKSB8
DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQUREUl9PRl8yNTZCX0JM
T0NLKGNoYW5uZWxfaW5kZXgpIHwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBPRkZTRVRfSU5fMjU2Ql9CTE9DSyhlcnJfYWRkcik7DQorDQorICAgICAgICAgICAgICAg
ICAgICAgICAvKiBUaGUgdW1jIGNoYW5uZWwgYml0cyBhcmUgbm90IG9yaWdpbmFsIHZhbHVlcywg
dGhleSBhcmUgaGFzaGVkICovDQorICAgICAgICAgICAgICAgICAgICAgICBTRVRfQ0hBTk5FTF9I
QVNIKGNoYW5uZWxfaW5kZXgsIHNvY19wYSk7DQorDQorICAgICAgICAgICAgICAgICAgICAgICBk
ZXZfaW5mbyhhZGV2LT5kZXYsICJFcnJvciBBZGRyZXNzKFBBKTogMHglbGx4XG4iLCBzb2NfcGEp
Ow0KKyAgICAgICAgICAgICAgIH0NCiAgICAgICAgIH0NCiB9DQoNCkBAIC0zOTUsNyArNDQwLDgg
QEAgc3RhdGljIHZvaWQgdW1jX3Y2XzdfcXVlcnlfcmFzX2Vycm9yX2NvdW50KHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGNoX2luc3QpOw0KICAgICAgICAgICAgICAgICB1bWNfdjZfN19x
dWVyeV9jb3JyZWN0YWJsZV9lcnJvcl9jb3VudChhZGV2LA0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bWNfcmVnX29mZnNldCwNCi0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmKGVycl9k
YXRhLT5jZV9jb3VudCkpOw0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICYoZXJyX2RhdGEtPmNlX2NvdW50KSwNCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjaF9pbnN0LCB1bWNfaW5zdCk7
DQogICAgICAgICAgICAgICAgIHVtY192Nl83X3F1ZXJyeV91bmNvcnJlY3RhYmxlX2Vycm9yX2Nv
dW50KGFkZXYsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHVtY19yZWdfb2Zmc2V0LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmKGVycl9kYXRhLT51ZV9jb3VudCkpOw0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvYWxkZWJhcmFu
X3BwdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9hbGRlYmFyYW5fcHB0
LmMNCmluZGV4IDljZGZlZWE1ODA4NS4uYzdlMGZlYzYxNGVhIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9hbGRlYmFyYW5fcHB0LmMNCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvYWxkZWJhcmFuX3BwdC5jDQpAQCAtMTg4Myw2
ICsxODgzLDcgQEAgc3RhdGljIHNzaXplX3QgYWxkZWJhcmFuX2dldF9lY2NfaW5mbyhzdHJ1Y3Qg
c211X2NvbnRleHQgKnNtdSwNCiAgICAgICAgICAgICAgICAgICAgICAgICBlY2NfaW5mb19wZXJf
Y2hhbm5lbC0+bWNhX2NldW1jX2FkZHIgPQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZWNjX3RhYmxlLT5FY2NJbmZvX1YyW2ldLm1jYV9jZXVtY19hZGRyOw0KICAgICAgICAgICAg
ICAgICB9DQorICAgICAgICAgICAgICAgZWNjaW5mby0+cmVjb3JkX2NlX2FkZHJfc3VwcG9ydGVk
ID0xOw0KICAgICAgICAgfQ0KDQogICAgICAgICByZXR1cm4gcmV0Ow0KLS0NCjIuMTcuMQ0K

--_000_BL1PR12MB533450EE99DEF72669FAC0E39AD69BL1PR12MB5334namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:=CB=CE=CC=E5;}
p.plaintext, li.plaintext, div.plaintext
	{mso-style-name:plaintext;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:=CB=CE=CC=E5;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:DengXian;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1302730390;
	mso-list-template-ids:1004170488;}
@list l0:level2
	{mso-level-start-at:0;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level3
	{mso-level-start-at:0;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level4
	{mso-level-start-at:0;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level5
	{mso-level-start-at:0;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level6
	{mso-level-start-at:0;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level7
	{mso-level-start-at:0;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level8
	{mso-level-start-at:0;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level9
	{mso-level-start-at:0;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1
	{mso-list-id:1646272050;
	mso-list-template-ids:567702136;}
@list l1:level2
	{mso-level-start-at:0;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level3
	{mso-level-start-at:0;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level4
	{mso-level-start-at:0;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level5
	{mso-level-start-at:0;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level6
	{mso-level-start-at:0;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level7
	{mso-level-start-at:0;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level8
	{mso-level-start-at:0;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level9
	{mso-level-start-at:0;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style>
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;" a=
lign=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"col=
or:black">=B7=A2=BC=FE=C8=CB</span></b><b><span lang=3D"EN-US" style=3D"fon=
t-family:&quot;Calibri&quot;,sans-serif;color:black">:</span></b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
> Wang,
 Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;<br>
</span><b><span style=3D"color:black">=C8=D5=C6=DA</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black">
</span><span style=3D"color:black">=D0=C7=C6=DA=C8=FD</span><span lang=3D"E=
N-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">, 20=
22</span><span style=3D"color:black">=C4=EA</span><span lang=3D"EN-US" styl=
e=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">5</span><span =
style=3D"color:black">=D4=C2</span><span lang=3D"EN-US" style=3D"font-famil=
y:&quot;Calibri&quot;,sans-serif;color:black">25</span><span style=3D"color=
:black">=C8=D5</span><span style=3D"font-family:&quot;Calibri&quot;,sans-se=
rif;color:black">
</span><span style=3D"color:black">=CF=C2=CE=E7</span><span lang=3D"EN-US" =
style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">2:52<br>
</span><b><span style=3D"color:black">=CA=D5=BC=FE=C8=CB</span></b><b><span=
 lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:b=
lack">:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&q=
uot;,sans-serif;color:black"> Yang, Stanley &lt;Stanley.Yang@amd.com&gt;, a=
md-gfx@lists.freedesktop.org
 &lt;amd-gfx@lists.freedesktop.org&gt;, Zhang, Hawking &lt;Hawking.Zhang@am=
d.com&gt;, Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;, Quan, Evan &lt;Evan.Quan@a=
md.com&gt;, Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
</span><b><span style=3D"color:black">=D6=F7=CC=E2</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black"> Re: [PATCH Review v3 2/2] drm/amdgpu: print umc
 correctable error address<o:p></o:p></span></p>
</div>
<p style=3D"margin:5.0pt"><span lang=3D"EN-US" style=3D"font-size:10.0pt;fo=
nt-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only -=
 General]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif;color:black">From:</span></b><span=
 lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:black"> amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&g=
t;
 on behalf of Stanley.Yang &lt;Stanley.Yang@amd.com&gt;<br>
<b>Sent:</b> Wednesday, May 25, 2022 2:10 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1=
@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;; Lazar, Lijo &lt;Lijo.La=
zar@amd.com&gt;<br>
<b>Cc:</b> Yang, Stanley &lt;Stanley.Yang@amd.com&gt;<br>
<b>Subject:</b> [PATCH Review v3 2/2] drm/amdgpu: print umc correctable err=
or address</span><span lang=3D"EN-US">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Chan=
ged from V1:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remove unnecessary same row phys=
ical address calculation<br>
<br>
Changed from V2:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; move record_ce_addr_supported to=
 umc_ecc_info struct<br>
<br>
Signed-off-by: Stanley.Yang &lt;Stanley.Yang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 5 ++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/umc_v6_7.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 50 ++++++++++++++++++-<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c&nbsp;&nbsp;&nbsp; |&nbsp; =
1 +<br>
&nbsp;3 files changed, 54 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h<br>
index 28e603243b67..bf5a95104ec1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
@@ -333,6 +333,11 @@ struct ecc_info_per_ch {<br>
&nbsp;<br>
&nbsp;struct umc_ecc_info {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ecc_info_per_ch ecc=
[MAX_UMC_CHANNEL_NUM];<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Determine smu ecctable whether sup=
port<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * record correctable error addr=
ess<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int record_ce_addr_supported;<br>
&nbsp;};<br>
&nbsp;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">[kev=
in]:<o:p></o:p></span></p>
</div>
<div>
<ol start=3D"1" type=3D"1">
<li class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-=
alt:auto;mso-list:l0 level1 lfo1">
<span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif">t=
he new field of&nbsp;</span><i><span lang=3D"EN-US" style=3D"font-size:11.0=
pt;font-family:&quot;Segoe UI&quot;,sans-serif;color:black;background:white=
">record_ce_addr_supported&nbsp;</span></i><span lang=3D"EN-US" style=3D"fo=
nt-family:&quot;Calibri&quot;,sans-serif">is
 not set on&nbsp;sienna_cichlid chip.</span><span lang=3D"EN-US" style=3D"f=
ont-size:11.0pt"><o:p></o:p></span></li></ol>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:DengXia=
n">Stanley: Sienna_cichild not support this feature, so do not set record_c=
e_addr_supported.<o:p></o:p></span></p>
</div>
<ol start=3D"1" type=3D"1">
<li class=3D"plaintext" style=3D"mso-list:l1 level1 lfo2"><span lang=3D"EN-=
US" style=3D"font-size:11.0pt">and this field is better to renamed to other=
s when this ecc table(pmfw side) update again in the furture. .e.g: ecc_tab=
le_version<o:p></o:p></span></li></ol>
<p class=3D"plaintext"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">Stanley: To name record_ce_addr_supported is more intuitiv=
e then using ecc_table_version or others.<o:p></o:p></span></p>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif">Best Regards<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif">Kevin</span><span lang=3D"EN-US" style=3D"font-size:1=
1.0pt"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-size:11.0pt">&nbsp;struct amdgpu_ras {</span><span lang=3D"EN=
-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">diff --git a/drivers=
/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c</spa=
n><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">index 606892dbea1c..=
bf7524f16b66 100644</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">--- a/drivers/gpu/dr=
m/amd/amdgpu/umc_v6_7.c</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+++ b/drivers/gpu/dr=
m/amd/amdgpu/umc_v6_7.c</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">@@ -119,6 +119,24 @@=
 static void umc_v6_7_ecc_info_query_correctable_error_count(struct amdgpu_=
device</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; *error_count +=3D 1;</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;</span><span l=
ang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; umc_v6_7_query_error_status_helper(adev, mc_umc_status, umc_reg_offset);<=
/span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+</span><span lang=
=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ras-&=
gt;umc_ecc.record_ce_addr_supported)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {</span>=
<span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t err_addr, soc_pa;</span><sp=
an lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t channel_index =3D</span><sp=
an lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; adev-&gt;umc.channel_idx_tbl[umc_inst * adev-&gt;umc.channel_in=
st_num + ch_inst];</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+</span><span lang=
=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err_addr =3D ras-&gt;umc_ecc.ecc[ecc=
info_table_idx].mca_ceumc_addr;</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err_addr =3D REG_GET_FIELD(err_addr,=
 MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* translate umc channel address to =
soc pa, 3 parts are included */</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc_pa =3D ADDR_OF_8KB_BLOCK(err_add=
r) |</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ADDR_OF_256B_BL=
OCK(channel_index) |</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OFFSET_IN_256B_=
BLOCK(err_addr);</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+</span><span lang=
=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The umc channel bits are not orig=
inal values, they are hashed */</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SET_CHANNEL_HASH(channel_index, soc_=
pa);</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+</span><span lang=
=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;Error A=
ddress(PA): 0x%llx\n&quot;, soc_pa);</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span><=
span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;}</span><span =
lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;</span><span l=
ang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">@@ -251,7 +269,9 @@ =
static void umc_v6_7_ecc_info_query_ras_error_address(struct amdgpu_device =
*adev</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;</span><span l=
ang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;static void um=
c_v6_7_query_correctable_error_count(struct amdgpu_device *adev,</span><spa=
n lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t umc_=
reg_offset,</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">-&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long *error_cou=
nt)</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long *error_cou=
nt,</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ch_inst,</span>=
<span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t umc_inst)</span=
><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;{</span><span =
lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ecc_err_cnt_sel, ecc_err_cnt_sel_addr=
;</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ecc_err_cnt, ecc_err_cnt_addr;</span>=
<span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">@@ -295,6 +315,31 @@=
 static void umc_v6_7_query_correctable_error_count(struct amdgpu_device *a=
dev,</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; *error_count +=3D 1;</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;</span><span l=
ang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; umc_v6_7_query_error_status_helper(adev, mc_umc_status, umc_reg_offset);<=
/span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+</span><span lang=
=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {</span><=
span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t err_addr, soc_pa;</span><sp=
an lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mc_umc_addrt0;</span><span =
lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t channel_index;</span><span =
lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+</span><span lang=
=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc_umc_addrt0 =3D</span><span lang=
=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_ADDRT0);</span><=
span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+</span><span lang=
=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; channel_index =3D</span><span lang=
=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; adev-&gt;umc.channel_idx_tbl[umc_inst * adev-&gt;umc.channel_in=
st_num + ch_inst];</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+</span><span lang=
=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err_addr =3D RREG64_PCIE((mc_umc_add=
rt0 + umc_reg_offset) * 4);</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err_addr =3D REG_GET_FIELD(err_addr,=
 MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+</span><span lang=
=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* translate umc channel address to =
soc pa, 3 parts are included */</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc_pa =3D ADDR_OF_8KB_BLOCK(err_add=
r) |</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ADDR_OF_256B_BL=
OCK(channel_index) |</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OFFSET_IN_256B_=
BLOCK(err_addr);</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+</span><span lang=
=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The umc channel bits are not orig=
inal values, they are hashed */</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SET_CHANNEL_HASH(channel_index, soc_=
pa);</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+</span><span lang=
=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;Error A=
ddress(PA): 0x%llx\n&quot;, soc_pa);</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span><=
span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;}</span><span =
lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;</span><span l=
ang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">@@ -395,7 +440,8 @@ =
static void umc_v6_7_query_ras_error_count(struct amdgpu_device *adev,</spa=
n><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; ch_inst);</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; umc_v6_7_query_correctable_error_count(adev,</span><span lang=3D"EN-US"><=
br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; umc_reg_offset,</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">-&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&amp;(err_data-&gt;ce_count));</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&amp;(err_data-&gt;ce_count),</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ch_inst, umc_inst);</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; umc_v6_7_querry_uncorrectable_error_count(adev,</span><span lang=3D"EN-US=
"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_reg_offset,</span><span lang=3D"EN-US"><br=
>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;(err_data-&gt;ue_count));</span><span lan=
g=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">diff --git a/drivers=
/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/=
smu13/aldebaran_ppt.c</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">index 9cdfeea58085..=
c7e0fec614ea 100644</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">--- a/drivers/gpu/dr=
m/amd/pm/swsmu/smu13/aldebaran_ppt.c</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+++ b/drivers/gpu/dr=
m/amd/pm/swsmu/smu13/aldebaran_ppt.c</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">@@ -1883,6 +1883,7 @=
@ static ssize_t aldebaran_get_ecc_info(struct smu_context *smu,</span><spa=
n lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_info_per_channel-&gt;=
mca_ceumc_addr =3D</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; ecc_table-&gt;EccInfo_V2[i].mca_ceumc_addr;</span><s=
pan lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; }</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eccinfo-&=
gt;record_ce_addr_supported =3D1;</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;</span><span l=
ang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span><span lang=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">-- </span><span lang=
=3D"EN-US"><br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt">2.17.1</span><span l=
ang=3D"EN-US"><o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB533450EE99DEF72669FAC0E39AD69BL1PR12MB5334namp_--
