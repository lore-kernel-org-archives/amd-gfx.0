Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A1DC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 14:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5153B61585
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 14:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5153B61585
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E43906E8E3;
	Tue, 23 Mar 2021 14:15:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 417AB6E8E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 14:15:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmxcp2FguUiG1obv/l1Qrh13R+888yU+X8fbKIAq/sGOgqJDO8GwaMuKOG/O0m5sS7KFVypOpAm0uN0MGE+u19qGi6xhDVxtwq6puBcMu/v8QfskxRfwcVyCYhjy3N8Hdnm2MpWTARh3+hHjXiuRhHicmTLNTcr1unwacGaWcOj5avDsqZvk/nAPYByDYLx0uk8jI+DsFbGhPH4+rRLWNe88fmjfkNJF5Xd7qQM+W9QqcPLm01wfhK+t2epJst1S7izcf7KZSPT0VX/5Bjcvf5PGTeuf7xI4V9rdW8aVuuZ/8T5meIy39GJBZdeoOtkkrmizxz+tiLx9ziG575vFfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZYEP05omRsn+01PPUDxSS5svMDTCF2EOHYsXbNLYxg=;
 b=khVkO5lfyWBszjuZSG0qo/gTZ4wm52nVbG0U2pQ/k1bfSOqMgWiuGI+026YT87TxVFP0gmAZZRncABpziIBxuHYk/1og6VAAP2/e5QK0eIoYuO7HOfZb5rLPjoAdJxuVlnORnPVYnCi5Ugglu/hOhDsCVRHZ5BS2LL93FeeNBw/mQhUlQSq4KNzf1zy31voWHheG/3ApnGYI1XlwRFDC6JCz1qDUeceqNo6YoMj5rAV/eoW/INny8IXpxYo67dd+0R1ztkmn8ijILUP8mMlpa1yRDUox1jmT8M3CB68/DrftSDcu3aa7Shqz/h/zQgpBngsZTG3azilwymSEgpB9XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZYEP05omRsn+01PPUDxSS5svMDTCF2EOHYsXbNLYxg=;
 b=UPg1x0IhBtk3+QFtO5Hwh43iLGzhxLEeLDaMAyl+bkRnxkq2M2kBUUwBtU6Jn8x0enrQa7/m0OWyto8eGeJ0hpb/bHI7lG9wSJOqpfNdm//ClZFQZeyDeFsJTqOuLvv3sUebC2+PJXX/PrbzW12lwck5lHlytnoYiX5h3gykfhI=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 14:15:15 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408%5]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 14:15:15 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Zeng, Oak" <Oak.Zeng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Introduce new SETUP_TMR interface
Thread-Topic: [PATCH 2/2] drm/amdgpu: Introduce new SETUP_TMR interface
Thread-Index: AQHXF4Yk73RnysV6HEG0QyBaczvQ3KqQGSOAgAGSt9A=
Date: Tue, 23 Mar 2021 14:15:15 +0000
Message-ID: <MN2PR12MB45497ABEA192A9158688153A97649@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <1615584275-16432-1-git-send-email-Oak.Zeng@amd.com>
 <1615584275-16432-2-git-send-email-Oak.Zeng@amd.com>
 <0FD452A0-140A-40CF-A6F6-93F775FBADB2@amd.com>
In-Reply-To: <0FD452A0-140A-40CF-A6F6-93F775FBADB2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-23T14:15:12Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=501ea5c7-53ad-45fd-a083-ddfe7c9b256d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f9d8141d-d5b1-47d1-24ee-08d8ee0614a8
x-ms-traffictypediagnostic: MN2PR12MB4389:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4389F6AE31D2EBC57480F4D797649@MN2PR12MB4389.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OypLMkGc/0eJrG8p36xtMA6Y7KdN0vcctLA7VQRqgKGPtQkYYta4uQl3v838mtgYkOZPaoz5uLjZTgbCIN0H64M0WnbNYYCBmUrlaaB4sCQbtLVOfdiX2v/Hya0NpnoglO+PS4KaqQbo6W+OjWFHZj5NinNkSIU4zhQs9uCSXItuHZUGRfjz1S1vIietPvy6rTOT108HYAnjdRR3VeAflmP6af0uaWOITJYIx3hM79wUwssp/GreJcUJ3sF8Ief5DvzS8xw/CoIik0K9RdoHaNaoyr4P2amqtFT3Zcm0dl+IO43gOlQlEwvKZzOdJaZ74Kp8FBThp3vo6d3NOzmLrEyF/ECnjaEPYrp97YWP+n7k8IbVMwTqd9G4U2GW48PshgqOYOXRqgg7Bixj/KDUbB+v8PWH+r43hxsBJIfBPszgDJcjNOn8AJ++xArWRiwUZsMg4VXKBhzvT5UuR2kIseoqcpPUXmCucXpG7n4W+qOeaoJvPusv1L6aF3S2skFuHLRBybHZ6+VqkH0jWO56jwz9GaCD4J6TeJ8TGfiIcE0rplRC6Yfdla7oRUq0wh0LaUOeD0k6PgOUPYUyUncTk3S874GAzdeTktt1Ov4CE+1aqoP0kjwVBgfTvjBC2XfiDSbvzvUZIKwKWo7We908VDjdl04OkpoUmn+LrukCWlBG5cR7uo+kg2KUk+Vp2Gxz/y+hY5DzVxB1aRwhvz3XtQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(86362001)(6506007)(54906003)(26005)(71200400001)(66946007)(2906002)(66446008)(66556008)(316002)(76116006)(66476007)(478600001)(186003)(64756008)(966005)(110136005)(5660300002)(55016002)(53546011)(45080400002)(33656002)(38100700001)(4326008)(8676002)(8936002)(9686003)(52536014)(83380400001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?MlpyZi9jZTlra0RQWEJtOU5PcEx0REIzYWxpZnpoSDdoSWVjT1FmcGNEdDRB?=
 =?utf-8?B?K0lFRktZNnJ6LzVCN2JBWkYzMmtqS0ZNTDB6NUI4SE44L04xVjF2enJEeGRa?=
 =?utf-8?B?TE81K09jSVVyZFY1WmhucnJzc3ZyVHZLNEY5SnpydU1MbXZ5SXpTTTY1OVZR?=
 =?utf-8?B?akVNaHovRFNTQ1llZFJXcndDcWpnTFVtUXZ1OUw0ZFNucHRwcG9PZWFDcWJX?=
 =?utf-8?B?bDFHejdqaTlWTlgwNHRIR29kU1BEcmVPUVNYbUFGK0NrczZBZWVaNUlpNUo4?=
 =?utf-8?B?ckdMTGpjbEErSEJyT0ZzTHRTWXh3WTVJTzVwYUkrSlFONjdWa0VpdjdNZWx3?=
 =?utf-8?B?Smp4K0d0ckFvdTJzNzdsNmR0aTljeGhFNWtBQUY0OGJLSWxIcHk1NlFmTWRB?=
 =?utf-8?B?RzNzN1hYN3Urbnl2RHJsazY5WWVvM2o3bUEvb3lvVlgwNEdWcWNNK3IvZUJ2?=
 =?utf-8?B?V1Nha2k3LzdHS1E4S3p2K2xmOEF1M1VrVThKTjJvWVVpSEhIajNUTzhyQjQ5?=
 =?utf-8?B?T0RtQ3RFQXY1czA5cHBPSVZjQU9ORHZQSUlZNi9teVNlcE9mZkJRVEZIS01j?=
 =?utf-8?B?TEZocFp4MTcyRENkMlcvVklIV2g5WGRidVhrcVhxSHdqVmxzU0JKa3FLbkZT?=
 =?utf-8?B?S1hnNTMzeWpsUEI2dVk1RGJoOGthMWhuRk1WejB4Q0JzRFBPRlVKZXZhY2ZB?=
 =?utf-8?B?TWhBWXE5ems4M2lRc0FuQnVjMHdUeVhNb295UENRdERXUVIwVm1lT1ZDVlA5?=
 =?utf-8?B?N0JoTm9mZkFNLzV3THg3ejZnbnlOSjZKcHJWcTBqMWJlZTZFY3BraFZRazA4?=
 =?utf-8?B?M3FyQWFBY1crdEpic1dqejlSZUUvZ2c4cnRrK0lzbFF6d0tCSWVuYU9iRVBS?=
 =?utf-8?B?eEN5bnNEUFZlb2FkZ0dvdlN2Z0ZsaHBKNDlzNVZBanZ6eEFlRjZ3ZU1QdVlJ?=
 =?utf-8?B?dG11enpyY2xkTnFubnFqUE5BT3Vac3hScnUwUEtqcmhZQ0QzS0gzVms0RzU1?=
 =?utf-8?B?OHpmU2tiOWFhUFYzK00zV3VTaHB6bEtOVUppOVFaRmp6ay9HTXZ3RlJ6Yndv?=
 =?utf-8?B?QkZpU3RWVXE2azJrTXNpQS9wL3QwS1JvNy83WGYxc1BrSU5EeXJ1ckFNYU4z?=
 =?utf-8?B?NVB5Q3NFZEFKNjVGaHcvOW4vNUFLQUMvdE9sS3ZZNVdKQ0VXTnZiQnNqeklx?=
 =?utf-8?B?T1lRcjMrZStGSkpMSVl3L2owWFVxUGpqT0pyOHk0N28yTngvR2Y5cys1YytC?=
 =?utf-8?B?OFd4V2srRVFoRGFhQ2F5T0grVFltTUVKc2l6cU8rUFlSYWZlV1pCOGlZNkRK?=
 =?utf-8?B?UlBmeHBBLzdkVXpZZ0xNb1BhaE1hRmp6djcyenJFOXBIelFrZEFUQ2pULytX?=
 =?utf-8?B?V1kyNUVta2NOMlZVNHRTNkQvWERNMXJ0Tkx0N3paNWVYLyt2L1NrTFU5ZG1u?=
 =?utf-8?B?VEtkZTFnNFl6ZDZCbVovYUZOdlNITm1JbERLdzkwQW1ZeGhVY0RNVnFiMDM4?=
 =?utf-8?B?QTFIUVZ0cm9DMnVLQUd4Z2Z2bUp6YitpcXZic1VqRmYwWUFKaXl1WjE1NTVO?=
 =?utf-8?B?aU54YmZ1TW9ibTJpbTNZNEhEWTVEbVNaNFJLcDRyRHFOU2hiVThaRzNFSkxG?=
 =?utf-8?B?OFNsVU5TbEhsd1FKQ2VVOFA4blBWOUZPTnYxZHppTWRMUHZCTk5NazdsU3Rh?=
 =?utf-8?B?ZjhzaUtyQ0w4K2g2VG9IQlg1Kzg2bDZWKzZQQzlwVnVxZVBjZXJyNEZ2OW9C?=
 =?utf-8?Q?KJTEuEAbp/SPB6dB8dnT9rW2AyHwNn/NdFY9JQe?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d8141d-d5b1-47d1-24ee-08d8ee0614a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 14:15:15.4771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FP2RyfTjALIzBDtATNcU33UsKN7Ua7J8aVCc/nsosTfWFi7KYgVjFEmc1y6CmzvA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBh
bWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYg
T2YgWmVuZywgT2FrDQpTZW50OiBNb25kYXksIE1hcmNoIDIyLCAyMDIxIDc6MzMgUE0NClRvOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXgu
S3VlaGxpbmdAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+
DQpTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gZHJtL2FtZGdwdTogSW50cm9kdWNlIG5ldyBTRVRV
UF9UTVIgaW50ZXJmYWNlDQoNCltBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBJbnRlcm5hbCBEaXN0
cmlidXRpb24gT25seV0NCg0KW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3Ry
aWJ1dGlvbiBPbmx5XQ0KDQpIZWxsbyBhbGwsDQoNCkNhbiBzb21lb25lIGhlbHAgdG8gcmV2aWV3
IGJlbG93IHBhdGNoZXM/IFdlIHZlcmlmaWVkIHdpdGggZmlybXdhcmUgdGVhbSBhbmQgd2FudCB0
byBjaGVjay1pbiB0b2dldGhlciB3aXRoIHBzcCBmaXJtd2FyZQ0KDQpSZWdhcmRzLA0KT2FrDQoN
Cg0KDQrvu79PbiAyMDIxLTAzLTEyLCA0OjI0IFBNLCAiWmVuZywgT2FrIiA8T2FrLlplbmdAYW1k
LmNvbT4gd3JvdGU6DQoNCiAgICBUaGlzIG5ldyBpbnRlcmZhY2UgcGFzc2VzIGJvdGggdmlydHVh
bCBhbmQgcGh5c2ljYWwgYWRkcmVzcw0KICAgIHRvIFBTUC4gSXQgaXMgYmFja3dvcmQgY29tcGF0
aWJsZSB3aXRoIG9sZCBpbnRlcmZhY2UuDQoNCiAgICBTaWduZWQtb2ZmLWJ5OiBPYWsgWmVuZyA8
T2FrLlplbmdAYW1kLmNvbT4NCiAgICAtLS0NCiAgICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3BzcC5jIHwgMTMgKysrKysrKysrKy0tLQ0KICAgICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9wc3BfZ2Z4X2lmLmggfCAxMSArKysrKysrKysrLQ0KICAgICAyIGZpbGVzIGNo
YW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCiAgICBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jDQogICAgaW5kZXggY2QzZWRhOS4uOTllMWEzZSAx
MDA2NDQNCiAgICAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMN
CiAgICArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCiAgICBA
QCAtMzI4LDggKzMyOCwxMyBAQCBwc3BfY21kX3N1Ym1pdF9idWYoc3RydWN0IHBzcF9jb250ZXh0
ICpwc3AsDQoNCiAgICAgc3RhdGljIHZvaWQgcHNwX3ByZXBfdG1yX2NtZF9idWYoc3RydWN0IHBz
cF9jb250ZXh0ICpwc3AsDQogICAgICBzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kLA0KICAg
IC0gdWludDY0X3QgdG1yX21jLCB1aW50MzJfdCBzaXplKQ0KICAgICsgdWludDY0X3QgdG1yX21j
LCBzdHJ1Y3QgYW1kZ3B1X2JvICp0bXJfYm8pDQogICAgIHsNCiAgICArc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYgPSBwc3AtPmFkZXY7DQogICAgK3VpbnQzMl90IHNpemUgPSBhbWRncHVfYm9f
c2l6ZSh0bXJfYm8pOw0KICAgICt1aW50NjRfdCB0bXJfcGEgPSBhbWRncHVfYm9fZ3B1X29mZnNl
dCh0bXJfYm8pICsNCiAgICArYWRldi0+dm1fbWFuYWdlci52cmFtX2Jhc2Vfb2Zmc2V0IC0gYWRl
di0+Z21jLnZyYW1fc3RhcnQ7DQogICAgKw0KDQo8PiBUaGlzIGxvb2tzIGxpa2UgYSBjYW5kaWRh
dGUgZm9yIGEgc21hbGwgaW5saW5lIGZ1bmN0aW9uIGluIGdtYy4gUFNQIGRvZXNuJ3QgbmVlZCB0
byBrbm93IGFib3V0IHRoZSBjYWxjdWxhdGlvbi4NCg0KVGhhbmtzLA0KTGlqbw0KDQogICAgIGlm
IChhbWRncHVfc3Jpb3ZfdmYocHNwLT5hZGV2KSkNCiAgICAgY21kLT5jbWRfaWQgPSBHRlhfQ01E
X0lEX1NFVFVQX1ZNUjsNCiAgICAgZWxzZQ0KICAgIEBAIC0zMzcsNiArMzQyLDkgQEAgc3RhdGlj
IHZvaWQgcHNwX3ByZXBfdG1yX2NtZF9idWYoc3RydWN0IHBzcF9jb250ZXh0ICpwc3AsDQogICAg
IGNtZC0+Y21kLmNtZF9zZXR1cF90bXIuYnVmX3BoeV9hZGRyX2xvID0gbG93ZXJfMzJfYml0cyh0
bXJfbWMpOw0KICAgICBjbWQtPmNtZC5jbWRfc2V0dXBfdG1yLmJ1Zl9waHlfYWRkcl9oaSA9IHVw
cGVyXzMyX2JpdHModG1yX21jKTsNCiAgICAgY21kLT5jbWQuY21kX3NldHVwX3Rtci5idWZfc2l6
ZSA9IHNpemU7DQogICAgK2NtZC0+Y21kLmNtZF9zZXR1cF90bXIuYml0ZmllbGQudmlydF9waHlf
YWRkciA9IDE7DQogICAgK2NtZC0+Y21kLmNtZF9zZXR1cF90bXIuc3lzdGVtX3BoeV9hZGRyX2xv
ID0gbG93ZXJfMzJfYml0cyh0bXJfcGEpOw0KICAgICtjbWQtPmNtZC5jbWRfc2V0dXBfdG1yLnN5
c3RlbV9waHlfYWRkcl9oaSA9IHVwcGVyXzMyX2JpdHModG1yX3BhKTsNCiAgICAgfQ0KDQogICAg
IHN0YXRpYyB2b2lkIHBzcF9wcmVwX2xvYWRfdG9jX2NtZF9idWYoc3RydWN0IHBzcF9nZnhfY21k
X3Jlc3AgKmNtZCwNCiAgICBAQCAtNDU2LDggKzQ2NCw3IEBAIHN0YXRpYyBpbnQgcHNwX3Rtcl9s
b2FkKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQ0KICAgICBpZiAoIWNtZCkNCiAgICAgcmV0dXJu
IC1FTk9NRU07DQoNCiAgICAtcHNwX3ByZXBfdG1yX2NtZF9idWYocHNwLCBjbWQsIHBzcC0+dG1y
X21jX2FkZHIsDQogICAgLSAgICAgYW1kZ3B1X2JvX3NpemUocHNwLT50bXJfYm8pKTsNCiAgICAr
cHNwX3ByZXBfdG1yX2NtZF9idWYocHNwLCBjbWQsIHBzcC0+dG1yX21jX2FkZHIsIHBzcC0+dG1y
X2JvKTsNCiAgICAgRFJNX0lORk8oInJlc2VydmUgMHglbHggZnJvbSAweCVsbHggZm9yIFBTUCBU
TVJcbiIsDQogICAgICBhbWRncHVfYm9fc2l6ZShwc3AtPnRtcl9ibyksIHBzcC0+dG1yX21jX2Fk
ZHIpOw0KDQogICAgZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF9n
ZnhfaWYuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF9nZnhfaWYuaA0KICAgIGlu
ZGV4IGE0MWIwNTQuLjYwNGExYzEgMTAwNjQ0DQogICAgLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvcHNwX2dmeF9pZi5oDQogICAgKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvcHNwX2dmeF9pZi5oDQogICAgQEAgLTE3MCwxMCArMTcwLDE5IEBAIHN0cnVjdCBwc3BfZ2Z4
X2NtZF9zZXR1cF90bXINCiAgICAgICAgIHVpbnQzMl90ICAgICAgICBidWZfcGh5X2FkZHJfbG87
ICAgICAgIC8qIGJpdHMgWzMxOjBdIG9mIEdQVSBWaXJ0dWFsIGFkZHJlc3Mgb2YgVE1SIGJ1ZmZl
ciAobXVzdCBiZSA0IEtCIGFsaWduZWQpICovDQogICAgICAgICB1aW50MzJfdCAgICAgICAgYnVm
X3BoeV9hZGRyX2hpOyAgICAgICAvKiBiaXRzIFs2MzozMl0gb2YgR1BVIFZpcnR1YWwgYWRkcmVz
cyBvZiBUTVIgYnVmZmVyICovDQogICAgICAgICB1aW50MzJfdCAgICAgICAgYnVmX3NpemU7ICAg
ICAgICAgICAgICAvKiBidWZmZXIgc2l6ZSBpbiBieXRlcyAobXVzdCBiZSBtdWx0aXBsZSBvZiA0
IEtCKSAqLw0KICAgICsgICAgdW5pb24gew0KICAgICtzdHJ1Y3Qgew0KICAgICt1aW50MzJfdHNy
aW92X2VuYWJsZWQ6MTsgLyogd2hldGhlciB0aGUgZGV2aWNlIHJ1bnMgdW5kZXIgU1ItSU9WKi8N
CiAgICArdWludDMyX3R2aXJ0X3BoeV9hZGRyOjE7IC8qIGRyaXZlciBwYXNzZXMgYm90aCB2aXJ0
dWFsIGFuZCBwaHlzaWNhbCBhZGRyZXNzIHRvIFBTUCovDQogICAgK3VpbnQzMl90cmVzZXJ2ZWQ6
MzA7DQogICAgK30gYml0ZmllbGQ7DQogICAgK3VpbnQzMl90ICAgICAgICB0bXJfZmxhZ3M7DQog
ICAgKyAgICB9Ow0KICAgICsgICAgdWludDMyX3QgICAgICAgIHN5c3RlbV9waHlfYWRkcl9sbzsg
ICAgICAgIC8qIGJpdHMgWzMxOjBdIG9mIHN5c3RlbSBwaHlzaWNhbCBhZGRyZXNzIG9mIFRNUiBi
dWZmZXIgKG11c3QgYmUgNCBLQiBhbGlnbmVkKSAqLw0KICAgICsgICAgdWludDMyX3QgICAgICAg
IHN5c3RlbV9waHlfYWRkcl9oaTsgICAgICAgIC8qIGJpdHMgWzYzOjMyXSBvZiBzeXN0ZW0gcGh5
c2ljYWwgYWRkcmVzcyBvZiBUTVIgYnVmZmVyICovDQoNCiAgICAgfTsNCg0KICAgIC0NCiAgICAg
LyogRlcgdHlwZXMgZm9yIEdGWF9DTURfSURfTE9BRF9JUF9GVyBjb21tYW5kLiBMaW1pdCAzMS4g
Ki8NCiAgICAgZW51bSBwc3BfZ2Z4X2Z3X3R5cGUgew0KICAgICBHRlhfRldfVFlQRV9OT05FICAg
ICAgICA9IDAsICAgIC8qICovDQogICAgLS0NCiAgICAyLjcuNA0KDQoNCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0K
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCmh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9w
Lm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDQlN0MwMSU3Q2xp
am8ubGF6YXIlNDBhbWQuY29tJTdDMGEzYzgwNDg1ZjgwNDMwMDc3NjYwOGQ4ZWQzYjNkZDElN0Mz
ZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3NTIwMTg1OTkwNTA4
OTU3JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lW
Mmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRhPTJZ
cDlvQ2ZYVGJzMVBBdHA5MEpwMjg3UGUxazcyS1ZXazdZQzlxckdONmslM0QmYW1wO3Jlc2VydmVk
PTANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
