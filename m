Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B03C433C1
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 03:26:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494AC619E6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 03:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494AC619E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D11316E32A;
	Wed, 24 Mar 2021 03:26:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 281C56E96C
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 03:26:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvfuH7phCIOjuVBPNO7BCfx2p+8v3injGfFoKu0Jzlnz00Ubo/MpF98pIKI3csazl4VbDrRn67zW14Kxt73PgZATF+XaHqUHkM2qFOCUsFKyzxxroKiMIr8WHJOfF+HvBdKrXcNwgbnD4UXEOn2I07NVsFfON4biu25zY46hsjgz+S08GVJqZ+a3sdwHTCioTrvr4UIDFLuf8eXFNv5UGRQ1VkY+4wsSqkHNlZl2gF+kWfSCvNzeW09JHydGqj1nSpPHg1Jbo6YLN9GMAIN3bMCQqMLb0jz2CcTzTF/vi+douksPzwTCH1zNpoz/YdpQbSqjnevhm6RAdIOO74JteA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqOq43X2TgeVrH0BJN30zdGjEt0QwYJtgQ2iUUJyD3k=;
 b=kMmROdWKi6WPVzwTWdCQdL3efUj3waX5+Dgupi69ElxBbZa/ys7sKYkNwogeGRR9RW4iGAHFtJG8LTx4fplwMWKHHvFTUiSF27vtS5bAyhDK+f7OK+0gTYbYPiQ2LWqxUbklvRDTGtvcLKSrzaDfUvuKcR1Io24DrqgJSQbc1//im7iDcUeLJjExw/lgOWi43RMnt9MzZ0Gll85KfwGZ+SMyTogPGHc+2Sl2eo10iA0uzlNkYorw8ePs3iShM8dU298IQRkvu91KY+F57FwjD9J9iuClg8wuXtJT3qzX7S1qgFJruR9X41+uNDLgNgPfyhIaYegsIYJ/V7TmUDTbbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqOq43X2TgeVrH0BJN30zdGjEt0QwYJtgQ2iUUJyD3k=;
 b=I02XKNOlTGN/GqvMMQqcupomsP2QWaGqreynrXXG/G5PfXVDDgLTbOyc2m5Pz+Zh2SlAo6KCLAHqlBGYRxjdTZ6CO1g5x6IXIW7UjEt5MUSC/m8tJRRUJcNTSeNLSEd5C7NjNVtvH5/t9hLJzH57CYdwGmTUqXsqzOqDTiDwDKI=
Received: from DM5PR1201MB0057.namprd12.prod.outlook.com (2603:10b6:4:5b::23)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.25; Wed, 24 Mar
 2021 03:26:32 +0000
Received: from DM5PR1201MB0057.namprd12.prod.outlook.com
 ([fe80::99bd:b7c0:520d:92dd]) by DM5PR1201MB0057.namprd12.prod.outlook.com
 ([fe80::99bd:b7c0:520d:92dd%11]) with mapi id 15.20.3955.027; Wed, 24 Mar
 2021 03:26:32 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: use zero as start for dummy resource walks
Thread-Topic: [PATCH 1/2] drm/amdgpu: use zero as start for dummy resource
 walks
Thread-Index: AQHXH/SCZyCJm1SPWUqjm+wU+XT/G6qSelAQ
Date: Wed, 24 Mar 2021 03:26:32 +0000
Message-ID: <DM5PR1201MB0057700875E337FCB79A11A787639@DM5PR1201MB0057.namprd12.prod.outlook.com>
References: <20210323145458.38910-1-christian.koenig@amd.com>
In-Reply-To: <20210323145458.38910-1-christian.koenig@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0585744f-f1b2-439d-9c5c-f608eb3765db;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-24T03:23:52Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bc6d8fe6-1a58-46ed-e148-08d8ee749efe
x-ms-traffictypediagnostic: DM6PR12MB4434:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB44347B10828BEB937104EE9487639@DM6PR12MB4434.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zALBJ9QUOoGnsIX9/1sQFxEuRmQsJAMKjBiHvL1SwiNpF+ndDA7ncn30xZPbBZQb5d+jhyWyQxRf2wRmnuABuU+iFEKCMfM5S3xdR/envySFvdt4G84emRmz9ncmXNUeMqX5Qck3eevclnbYD3+Wmkhv2D3JhiJwp9d9TuYZsx8DJ1gIDDQ9t5Ekf5flJaIeI6ZEorKKS3uwHsmtG6AK9oRLtnkcQvE6LiE8qybyalblIN0+KpmtCX4bS5rWOdM642loBv8F9xboNY2V5sPzo43a3329ke4hqDPkkaxBhqJ+6sqebB8NYmQzUwNv6oHZ5OzWUoyvaAhJW2RcLyTN2pBUWTTofld+YCtGAcsD07A9L0g7opZoFCxN++yodpFFMY7KQc1oiEk7cZcp+Xdqi+YpvKq4a3+k4ZeqEUOsjCxeUfgiTo8VWa33PpcpJ+YbnimhyFSfX3WbSBUmeZ/pj+66PIVP/DLQiRTVrZaknbg+YYgDn1zoo/h7XcGG3ibQ+XoYO7MpPK/CMjtt9e/M5eT1lVpzAcZOxrRq2ehuCWV1ZL2LpBbO7MIlo5N0TRkBDm5r9l8uT2qR1cHeHTr2iA+rLJNT+1QY5vxubyATGhtDGIKBg5xOBpQXQqGICr0eIbLzUtDPWnv86fq3yXl+bo/kUIr0NSv3i2GgqD5Gk7R6VnAv0XSxCGkib1+ITWtz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0057.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(26005)(6506007)(53546011)(7696005)(186003)(2906002)(45080400002)(64756008)(38100700001)(9686003)(8936002)(55016002)(4326008)(478600001)(316002)(8676002)(5660300002)(33656002)(71200400001)(83380400001)(66476007)(66556008)(966005)(66946007)(86362001)(76116006)(54906003)(66446008)(52536014)(110136005)(66574015);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?MzFYT1JidzZYcVNkd3hyaG5uL3RxUklYenhUYVAvdW44bkp6MTYxazdqbUow?=
 =?utf-8?B?WUtrbVNpN0tSZlFtZ2xibllaZ05mZnNkVHp6VHZvODdrSk9kdXM2YndXUXhV?=
 =?utf-8?B?UEREdFhialhqdmNsYmM1SjEwa1IxYmI4R2FCR3RkYzlwbXBMZjBZMzNuM0dt?=
 =?utf-8?B?dm1TTGNMNDZhb2FCTDU4ZVNQSGwrVXpLTTVhc2xvSWxXdVBvOFRkQVNGUWpo?=
 =?utf-8?B?ZVo2Qy9Jd0pxSGdrMzBWT0FiWlRSQ1VTd2pmYW5rQ3djNVQyeUNEZkpLMG1J?=
 =?utf-8?B?ekdTMHVGc0dPZ29lNGJ6M1JtRU9sZUp5RWlJMzdJQ0JkdEtvdXZ5SFkyR1lu?=
 =?utf-8?B?MkhhY09WalBJSEM2azJxcUZ4TG43d1RyekFvYzlBS1A3UkFHczZVRUs1TDB5?=
 =?utf-8?B?cm1DYjdueHhmbnpVL3pMNFVXU2hxeWxMUWR4Ukx3TjcrNU1CMXAyZm1jNlg0?=
 =?utf-8?B?UGpzdENuYm50MGZleXM5V3VROXVZa1lnQlBvZmt5bHBnU3U3bm8vSldsTDJn?=
 =?utf-8?B?cGFrQjZ6bHBBaGt2UHZZRFArV2ExQnl1Vmpvd0NnZ2xsK3pIazFvL3RQd1Iw?=
 =?utf-8?B?b1h5TWNvNVNSQktYYWtMY1ZZdzkwcnZoWUdraThxb25pQ0lEU2wzeGl1TjRZ?=
 =?utf-8?B?VUp0OWtEQkRsZ2pVay9vNytTNkdva2pwSmo4UVNKWWcvNzlOajhlR0xrWkYy?=
 =?utf-8?B?NHdrVFB3cjlMZXNObWVoQW9pcFBrTjBCYlZYSUxCWGVqcG96Yjh1UGN1ZTVa?=
 =?utf-8?B?OERPRVNnelYxTzZZNjFlUUc5bGJKYmlmZUttZ1pSd2NLWGJPb3pFbjU2TWRP?=
 =?utf-8?B?cSt1ZVZnQjVZa2hiWk9mYU5YU2hHY2dORUtEVTcvVENwYmtSMDFibTloUEZ5?=
 =?utf-8?B?UnpZOVg4UmtscFN2MlY2RzlHSW1TaUdrOVN4bVRGVTJsVlg4a0E5eG5weHlI?=
 =?utf-8?B?a2ZTUTN5cHVsUVpBcHV0VTUzWTN6SmZpcnV6blFZUityQU4xWlQvcS8vN2FD?=
 =?utf-8?B?b2lQNzRZOXpidGlOMDJRQmM0cFh0VDZxRjd0L2hiL3lVTm00YUV2U2NKYmVa?=
 =?utf-8?B?bysrYmg4U1ozSmlDNk5wM2hQS0N1M1BZTE1zcU52MjROWVRNVzZ5eWFaSVNR?=
 =?utf-8?B?NGFMMnphMVVibVJuejF6dGpvdWpHcHlNMzVSdHNqcElJaXRYMWpWcnhDeXNo?=
 =?utf-8?B?YldBNzR4ZnoybWFGU3lyVlQ3YlBjcS9yV2RlNlhzNFpZMFh4WGNWR0NwUTNG?=
 =?utf-8?B?NDNpRDFTQURsS2JqRDJ0NnRnZlpvMGFuSlB5K0JVSEIwWjF3QTNRajZSMUFn?=
 =?utf-8?B?Mi9xc2t3SEZ4eDdyQnZ4dUIvT3FDbHVGOUo5dVN5aXdOMnBsVUNHSG5TYzVx?=
 =?utf-8?B?RzlzZjRybUQ4S1FkVVhUY0ZEK2FsaWphY2NoMHBmN3Z2MTRjdnNudUFuQ2Zm?=
 =?utf-8?B?T2t5blBHN095dlNnU2lPZUxmNkc3d3QrdzRycERhaSs4TWRZblBWWVhzYTVS?=
 =?utf-8?B?b1JXNlpHV1h2VTBEOWx2UmQxRENoYVluZE5SUXJrb0RzU3NNV2tHdkVnUzhQ?=
 =?utf-8?B?SXlsdHVuQ2s4V0VMUDZZLzRjSU5jMFhqaEQ3SUI3aVhXaGRBcEJZeDRXUGJU?=
 =?utf-8?B?VlFHTDFJWFZCTGlKdlV0bm9kZTdTU3htbnAxT29XWFg0Y0JIVWVneVRiY0pZ?=
 =?utf-8?B?c2ZyakdMc3pRaTd1WTVManRFamRxZGxWcGJZWExpajdiMHl6Qk5hc3pEdkRs?=
 =?utf-8?Q?OsUUuMkmfCsY6pFc0qlNfKx17F76uiREB7OyRl1?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0057.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6d8fe6-1a58-46ed-e148-08d8ee749efe
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 03:26:32.2346 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IeLJXViXFMHeqw2JwFoyWxx+N6il1pkmV5i/qnWeO5BhgyXGWieWe76gfhJfmB4V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434
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
Cc: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpJ
IGRvbuKAmXQgdGhpbmsgc28uIFN0YXJ0IGlzIG9mZnNldCBoZXJlLiBXZSBnZXQgdGhlIHZhbGlk
IHBoeXNpY2FsIGFkZHJlc3MgZnJvbSBwYWdlc19hZGRyW29mZnNldF0gd2hlbiB3ZSB1cGRhdGUg
bWFwcGluZy4NCkJ0dywgd2hhdCBpc3N1ZSB3ZSBhcmUgc2VlaW5nPw0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIENocmlzdGlhbiBLP25pZw0KU2VudDogMjAyMeW5tDPm
nIgyM+aXpSAyMjo1NQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogRGFz
LCBOaXJtb3kgPE5pcm1veS5EYXNAYW1kLmNvbT47IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5A
YW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6IHVzZSB6ZXJvIGFzIHN0
YXJ0IGZvciBkdW1teSByZXNvdXJjZSB3YWxrcw0KDQpXaGVuIHdlIGRvbid0IGhhdmUgYSBwaHlz
aWNhbGx5IGJhY2tpbmcgc3RvcmUgd2Ugc2hvdWxkIHVzZSB6ZXJvIGluc3RlYWQgb2YgdGhlIHZp
cnR1YWwgc3RhcnQgYWRkcmVzcyBzaW5jZSB0aGF0IGlzbid0IG5lY2Vzc2FyeSBhIHZhbGlkIHBo
eXNpY2FsIG9uZS4NCg0KU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3Jlc19jdXJzb3IuaCB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9yZXNfY3Vyc29yLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVz
X2N1cnNvci5oDQppbmRleCA0MGYyYWRmMzA1YmMuLmU5NDM2MmNjZjlkNSAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNfY3Vyc29yLmgNCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNfY3Vyc29yLmgNCkBAIC01NCw3ICs1
NCw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBhbWRncHVfcmVzX2ZpcnN0KHN0cnVjdCB0dG1fcmVz
b3VyY2UgKnJlcywNCiBzdHJ1Y3QgZHJtX21tX25vZGUgKm5vZGU7DQoNCiBpZiAoIXJlcyB8fCAh
cmVzLT5tbV9ub2RlKSB7DQotY3VyLT5zdGFydCA9IHN0YXJ0Ow0KK2N1ci0+c3RhcnQgPSAwOw0K
IGN1ci0+c2l6ZSA9IHNpemU7DQogY3VyLT5yZW1haW5pbmcgPSBzaXplOw0KIGN1ci0+bm9kZSA9
IE5VTEw7DQotLQ0KMi4yNS4xDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCmh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20v
P3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0
aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDQlN0MwMSU3Q3hpbmh1aS5wYW4lNDBhbWQuY29tJTdD
MDMxYzc0M2JkN2M0NDhlOGQ5MTUwOGQ4ZWUwYmE0MDIlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4
MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3NTIxMDgxMDUzMTA1Mjk1JTdDVW5rbm93biU3Q1RXRnBi
R1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFX
d2lMQ0pYVkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRhPWxySjZrM1FCWHFNOUc2R1JLMjVmckZs
cUFOa2JmUjRrQXY2QTMlMkY4bXlCYyUzRCZhbXA7cmVzZXJ2ZWQ9MA0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
