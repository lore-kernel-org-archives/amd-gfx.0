Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA6DC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 05:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCF4261249
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 05:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF4261249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 873D789D4B;
	Wed, 14 Apr 2021 05:49:55 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2067.outbound.protection.outlook.com [40.107.100.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ABA789D4B
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 05:49:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfUv2hdnennLAQJIBFYLe4uPxfvMc9Lc4DxYE1PhfyUOxElb5rJ6VpVyNVwQnhkV/FrdBure03K9obVK1nfe9ZNUzTRnncZoAfnR+q78vq8pOgPhTJp23uG7ga70ObK/1dTaFMQh5W3rgADDSfm2vGJTwEsHFxBQ1hhn7aLjem1mI+TVt5ALp9Ko+PmMNBWHgkJhsxx1rkGZkKXE9DAmhkiW+unAMpGL8d57xmyK5JEu6QKQUucTfvV3fUFdVPAhPvWT+SbTRGyCtCvQyYdjDhCSk/8SGN1GvTF4yPiyZO8Cs2NEnLWKdhZJFnknwPS9p/Yu8omP51OzKDhNW7pK6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIVL6kVzHaqhfHiuFsKFIo4Q0JDgaB33wxqlXn8scu8=;
 b=mT+JJ5lpI0mIBuY/9C0f5WDGZWcziOSddOQgAYyva9WbJBpZP7CtC41YTQTW7M0Bde7Qjm4segI6+d1xzW65o+qTgF9yJppiqCLBp9q0ass+O4AC6KZO9btKMctp3xUSAFj4t8tZSEot9jSybich9EcI451xchv5w7SVaEEE+kJ9UoeYQzGK3s0XiiqfyzYbHzE2SZ79RNruGergSYC9ToGdjmnQ5Rx0xMZBXwcu2/gOM04ep3RZAi/1NRRYuUO6DvOd6qFeasESi8F2UIWl/LtFO6mTyoub/H2zoVMsbE7J6UxtWRcyhlACL599A/BJohZ6YmWZY3H1xKUg2frmuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIVL6kVzHaqhfHiuFsKFIo4Q0JDgaB33wxqlXn8scu8=;
 b=p8hDd3UUyVH808uooeey0JTjhKK2DgNLAhbkevsj6Y9jSv9WIHt6/RBjrycGlkGVNd+4yZVqb71F5pRqEcHVBrd6iQFD4x3abD3q57Wi2nxpJNaPbzNiGJ1/bPc7QvSVcNveA/Kb7EfEa5sml2ve9ldwUPo05tHgOp4S+rIYBGk=
Received: from BN6PR12MB1124.namprd12.prod.outlook.com (2603:10b6:404:19::10)
 by BN6PR1201MB0212.namprd12.prod.outlook.com (2603:10b6:405:56::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Wed, 14 Apr
 2021 05:49:52 +0000
Received: from BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::df2:b35d:351a:6c8a]) by BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::df2:b35d:351a:6c8a%6]) with mapi id 15.20.4020.023; Wed, 14 Apr 2021
 05:49:52 +0000
From: "Du, Xiaojian" <Xiaojian.Du@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: FW: [PATCH] drm/amd/pm: remove the "set" function of pp_dpm_mclk for
 vangogh
Thread-Topic: [PATCH] drm/amd/pm: remove the "set" function of pp_dpm_mclk for
 vangogh
Thread-Index: AQHXMDu31+0BDwqL9EiEiC9G1gg4YqqzgtzA
Date: Wed, 14 Apr 2021 05:49:51 +0000
Message-ID: <BN6PR12MB112431A20309BCCCBC4BD7F8F14E9@BN6PR12MB1124.namprd12.prod.outlook.com>
References: <20210413080351.2790122-1-Xiaojian.Du@amd.com>
In-Reply-To: <20210413080351.2790122-1-Xiaojian.Du@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f6845ea9-d90b-4aac-91d7-65a21164d854;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-14T05:47:33Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d237bd2-03f6-46bf-77fc-08d8ff091f79
x-ms-traffictypediagnostic: BN6PR1201MB0212:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1201MB0212FD91DB69D01C751D525FF14E9@BN6PR1201MB0212.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OOI7a2kEoazol9h+K4+XW8M0ytY5RCKdG95MnHIvxLjgat8wQG5eRSFbIUv53h2Jo7zLylu0BFPYRfjuKhtu6FsVVXselka8LxLdSnCvHU9EufFK/KkC4i5yXND+L9Uaajw5j+HGd4wrRk81JWnihRDWyvF/S6COAea3jm6j+qwWz5v5lATzuYXtrE5FsoZ4htc7xcCTZPyg3FwOWda5dt12gul1SkCQLOmcFq69usCTRqdqTauLVKhs4LOWE5f9rQTw/tFNt4Gw6lTTpDhn/hc+BaTcXPTWMz4ANHQ+9UKUGWZAMa0RcnNGrjMDMoipUyHrAFme5LfhR43Qb8VmPvq38EFNhx1Sfn7SdZcNMFdB+3Lfsjq6We86GmiXy0RqNIwEIk+o3/VQbBA1mD8o2yIanCFtXQQaDWBX5+SNAqwGtiqbeXNqEBrzsyLtzJL0c7gPlcJHtUyjaqt18FIddHvEAnJFDfj3F9GzhzbColdIn8NZvLbjlL6Cyq5ux4yeGvtxW0dpHojuQmHRtT2lF2a1Q0foKAssclQKVL4wbQMTYzOT9ZPj+IKD6ERztQjeft5tewvinXb8LpqqJgqHgVQi4DbVQ2l4isXfRbm4Zqs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(71200400001)(8676002)(66446008)(66476007)(66556008)(83380400001)(66946007)(478600001)(64756008)(86362001)(2906002)(38100700002)(26005)(33656002)(7696005)(122000001)(52536014)(186003)(6916009)(8936002)(76116006)(55016002)(54906003)(6506007)(9686003)(4326008)(53546011)(316002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?gb2312?B?WjBJYW9KTitKM3V4elZsSkZQdmY0aEZOdHdLQUc3dE0wY1QvT2JUbFI4TW5L?=
 =?gb2312?B?OThrZW1najdNM2toemJxNnVNd0pzWWpVTnBHdnR6WlpaL1NlbFdZUm55Y0Mv?=
 =?gb2312?B?SVRBMFl0K1h0QjBtMjQ4b2NzY3dxLzZxMFQ3cllBRFkrakx1YlVqdlVabnlX?=
 =?gb2312?B?dVE4bjRERVBXVGdkKytFV1dtKzJuRzRyb3NmdFM4YjdMeDBmK0QxdVhNb1ln?=
 =?gb2312?B?MFpKbzZOZVB4UWhHUjhKazBrN2pxUDExVnphQzlZUVdqRjEwZkVWTVRXRnBL?=
 =?gb2312?B?cUNxOEI0bHN2NldlWDFEdjdjbWFyRmZLU3lyWEIySG9zOVpJdDhLOXJtanYy?=
 =?gb2312?B?SEl5Qy9CdG5xcmxOUVdPSEtlbmp2ZDJmZnhPZ3BGa3BjT0trUXdmeDBqa3Nj?=
 =?gb2312?B?d3U3MkxLWmJKWC8xajVVY2IxcVhoaDJSMDBCWVpqSVBqUElkREdNS21TbUQv?=
 =?gb2312?B?QzF0UFlhLzQvWlJhL1J1bXgwWTJtWjdjNnpXdEJTNDhQd1puenBtQjMrNSsx?=
 =?gb2312?B?bUcrRkhuTlNVcmR6NjNvc1pCemZvdFVKWmNJNzJLb2hDeVVIOUx6MDV0OUNT?=
 =?gb2312?B?ZzlWUDVTaXVOdEl1dWxRcHhoM1NKWTgwekdOODJZdVdqeE1YejhQam9yRWZr?=
 =?gb2312?B?UlY4dUJlcm1JTEs4aWdDWnQ4bmdBMi9GWlhwcDFsRFQ5NDFoL2k3dEl6OWVp?=
 =?gb2312?B?T0xoM0daQVRLeVhiSFlqUFRtVC9qcnA5V3Fya2J3dHNhd1Y3MVBXQmJjeG1n?=
 =?gb2312?B?TmdDdXp5SW9EYTBySXllZTJpejA3SEVQZlg1VHRyMDhzNm5adGlPN0h3SSt5?=
 =?gb2312?B?UnNLcjU0OFAvVHBQRHFvU3JaWC8zSVRkTGxZM01BZE1yc2tsVVh1UDZwZWZ6?=
 =?gb2312?B?ekY2aXhCaGJ4SGt5UTZPeHZORGp0OFIrYkZ3L1NWKzliNmJUREFveTBEMG1v?=
 =?gb2312?B?RENic3F4U2VEZ2tlaGwvYTNDa0UwcGJOTDMvU3U0QndtUlAwSWd5ZDg0aGVX?=
 =?gb2312?B?Tkt0Q1dOTzgvQU96SkR3TU9RN01wTDk0MHBuckJ5MUgraUVUMlVZVXZMcDJS?=
 =?gb2312?B?SGJ0U1NyTU9hc3ZQYmNNSzZqdGN6cVh2RWQ0QTEveU1IM3NXUTZXZ3FoN29L?=
 =?gb2312?B?eUJQejN6akRYQ3pydUVkeWV0clNVaW9BbUcvcFUyQXppRlhldHcvOUJmK2tD?=
 =?gb2312?B?WHVFNVNISWNNY3Fvc0NUMjNiV0t0Q211ckh5eUtOWXk1b3RBUnJvbVhKcTRi?=
 =?gb2312?B?dm14dHIveU5jcGVobTBMUkNDMFJLRGRKc21aVmVTd1RGZ2VzakpVTTNCbUsr?=
 =?gb2312?B?RUQ5NWlyenp6d1NEQXpyYTdMbjhiR1hlK3ZBcG1VcnVsYUZLd0xSdXZTdGkv?=
 =?gb2312?B?NDlNRTFGTTFrY3dKSmRnbklrUFpoR1V5aGR4c1ZTYlRSTVNRVEVCbytwUlRj?=
 =?gb2312?B?UzdxcllMM0xZeTNjVkhHNmVobytBeWc2MVJTeHBhL2NobjFQQWxad3owajVa?=
 =?gb2312?B?ZDMyTFR5WUphcmpJVDJrRW9Pc3J3VjJTL2NpREo4NEhwVDkwZ3ZtbEZJcFor?=
 =?gb2312?B?NnZpbkhQNzRtLys4eFZ5UFU1amRXWmROZVJWZkwyakZZZ2dTYk9kd21GZ3Fa?=
 =?gb2312?B?bHNSWlA1N0VraGE0TWZFbEpmcG5sVHVpTnJ0MWVYeU1iOWpYamZJY3NPYkJV?=
 =?gb2312?B?N3VmRUQzcDZyZmkwdjJVREVzcU5sSEJraUdVL2VBbzZuaGowb2tnSGwyWE5W?=
 =?gb2312?Q?Zyc1oEN5GlT+gKyfpW0V0hdOKQzvDL0/rdkBD2m?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d237bd2-03f6-46bf-77fc-08d8ff091f79
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 05:49:51.9568 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wBXEhue5SrK5dD0IERJHrG/jQQzUbSE/bfQgGTgpFHhx2xr60jQbkEWKvlh9lhkKEwn+jP+UQ4Oyb4T440rMvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0212
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpG
b3J3YXJkIHRvIGNvbW11bml0eSBmb3IgcmV2aWV3Lg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogRHUsIFhpYW9qaWFuIDxYaWFvamlhbi5EdUBhbWQuY29tPg0KU2VudDogMjAy
McTqNNTCMTPI1SAxNjowNA0KVG86IGJyYWhtYV9zd19kZXYgPGJyYWhtYV9zd19kZXZAYW1kLmNv
bT4NCkNjOiBIdWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT47IFF1YW4sIEV2YW4gPEV2YW4u
UXVhbkBhbWQuY29tPjsgV2FuZywgS2V2aW4oWWFuZykgPEtldmluMS5XYW5nQGFtZC5jb20+OyBM
YXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPjsgRHUsIFhpYW9qaWFuIDxYaWFvamlhbi5E
dUBhbWQuY29tPg0KU3ViamVjdDogW1BBVENIXSBkcm0vYW1kL3BtOiByZW1vdmUgdGhlICJzZXQi
IGZ1bmN0aW9uIG9mIHBwX2RwbV9tY2xrIGZvciB2YW5nb2doDQoNClRoaXMgcGF0Y2ggaXMgdG8g
cmVtdm9lIHRoZSAic2V0IiBmdW5jdGlvbiBvZiBwcF9kcG1fbWNsayBmb3IgdmFuZ29naC4NCkZv
ciB2YW5nb2doLCBtY2xrIGJvbmRzIHdpdGggZmNsaywgdGhleSB3aWxsIGxvY2sgZWFjaCBvdGhl
ciBvbiB0aGUgc2FtZSBwZXJmb21hbmNlIGxldmVsLiBCdXQgYWNjb3JkaW5nIHRvIHRoZSBzbXUg
bWVzc2FnZSBmcm9tIHBtZncsIG9ubHkgZmNsayBpcyBhbGxvd2VkIHRvIHNldCB2YWx1ZSBtYW51
YWxseSwgc28gcmVtb3ZlIHRoZSB1bm5lY2Vzc2FyeSBjb2RlIG9mICJzZXQiIGZ1bmN0aW9uIGZv
ciBtY2xrLg0KDQpTaWduZWQtb2ZmLWJ5OiBYaWFvamlhbiBEdSA8WGlhb2ppYW4uRHVAYW1kLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvdmFuZ29naF9wcHQu
YyB8IDYgLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL3ZhbmdvZ2hfcHB0LmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL3ZhbmdvZ2hfcHB0LmMNCmluZGV4IDYx
ZmY5YTY2M2IyMS4uMzU5MDQzMTVjMWY5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9zd3NtdS9zbXUxMS92YW5nb2doX3BwdC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL3N3c211L3NtdTExL3ZhbmdvZ2hfcHB0LmMNCkBAIC0xMDkyLDcgKzEwOTIsNiBAQCBzdGF0
aWMgaW50IHZhbmdvZ2hfc2V0X3NvZnRfZnJlcV9saW1pdGVkX3JhbmdlKHN0cnVjdCBzbXVfY29u
dGV4dCAqc211LA0KIHJldHVybiByZXQ7DQogYnJlYWs7DQogY2FzZSBTTVVfRkNMSzoNCi1jYXNl
IFNNVV9NQ0xLOg0KIHJldCA9IHNtdV9jbW5fc2VuZF9zbWNfbXNnX3dpdGhfcGFyYW0oc211LA0K
IFNNVV9NU0dfU2V0SGFyZE1pbkZjbGtCeUZyZXEsDQogbWluLCBOVUxMKTsNCkBAIC0xMTgwLDcg
KzExNzksNiBAQCBzdGF0aWMgaW50IHZhbmdvZ2hfZm9yY2VfY2xrX2xldmVscyhzdHJ1Y3Qgc211
X2NvbnRleHQgKnNtdSwNCiBpZiAocmV0KQ0KIHJldHVybiByZXQ7DQogYnJlYWs7DQotY2FzZSBT
TVVfTUNMSzoNCiBjYXNlIFNNVV9GQ0xLOg0KIHJldCA9IHZhbmdvZ2hfZ2V0X2RwbV9jbGtfbGlt
aXRlZChzbXUsDQogY2xrX3R5cGUsIHNvZnRfbWluX2xldmVsLCAmbWluX2ZyZXEpOyBAQCAtMTI2
Nyw3ICsxMjY1LDYgQEAgc3RhdGljIGludCB2YW5nb2doX2ZvcmNlX2RwbV9saW1pdF92YWx1ZShz
dHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwgYm9vbCBoaWdoZXN0KQ0KIFNNVV9TT0NDTEssDQogU01V
X1ZDTEssDQogU01VX0RDTEssDQotU01VX01DTEssDQogU01VX0ZDTEssDQogfTsNCg0KQEAgLTEy
OTYsNyArMTI5Myw2IEBAIHN0YXRpYyBpbnQgdmFuZ29naF91bmZvcmNlX2RwbV9sZXZlbHMoc3Ry
dWN0IHNtdV9jb250ZXh0ICpzbXUpDQogZW51bSBzbXVfY2xrX3R5cGUgY2xrX3R5cGU7DQogdWlu
dDMyX3RmZWF0dXJlOw0KIH0gY2xrX2ZlYXR1cmVfbWFwW10gPSB7DQote1NNVV9NQ0xLLCAgIFNN
VV9GRUFUVVJFX0RQTV9GQ0xLX0JJVH0sDQoge1NNVV9GQ0xLLCBTTVVfRkVBVFVSRV9EUE1fRkNM
S19CSVR9LA0KIHtTTVVfU09DQ0xLLCBTTVVfRkVBVFVSRV9EUE1fU09DQ0xLX0JJVH0sDQoge1NN
VV9WQ0xLLCBTTVVfRkVBVFVSRV9WQ05fRFBNX0JJVH0sDQpAQCAtMTQyOCw3ICsxNDI0LDYgQEAg
c3RhdGljIGludCB2YW5nb2doX3NldF9wZXJmb3JtYW5jZV9sZXZlbChzdHJ1Y3Qgc211X2NvbnRl
eHQgKnNtdSwNCiBpZiAocmV0KQ0KIHJldHVybiByZXQ7DQoNCi12YW5nb2doX2ZvcmNlX2Nsa19s
ZXZlbHMoc211LCBTTVVfTUNMSywgMSA8PCBtY2xrX21hc2spOw0KIHZhbmdvZ2hfZm9yY2VfY2xr
X2xldmVscyhzbXUsIFNNVV9GQ0xLLCAxIDw8IGZjbGtfbWFzayk7DQogdmFuZ29naF9mb3JjZV9j
bGtfbGV2ZWxzKHNtdSwgU01VX1NPQ0NMSywgMSA8PCBzb2NfbWFzayk7DQogdmFuZ29naF9mb3Jj
ZV9jbGtfbGV2ZWxzKHNtdSwgU01VX1ZDTEssIDEgPDwgdmNsa19tYXNrKTsgQEAgLTE0NjgsNyAr
MTQ2Myw2IEBAIHN0YXRpYyBpbnQgdmFuZ29naF9zZXRfcGVyZm9ybWFuY2VfbGV2ZWwoc3RydWN0
IHNtdV9jb250ZXh0ICpzbXUsDQogaWYgKHJldCkNCiByZXR1cm4gcmV0Ow0KDQotdmFuZ29naF9m
b3JjZV9jbGtfbGV2ZWxzKHNtdSwgU01VX01DTEssIDEgPDwgbWNsa19tYXNrKTsNCiB2YW5nb2do
X2ZvcmNlX2Nsa19sZXZlbHMoc211LCBTTVVfRkNMSywgMSA8PCBmY2xrX21hc2spOw0KIGJyZWFr
Ow0KIGNhc2UgQU1EX0RQTV9GT1JDRURfTEVWRUxfUFJPRklMRV9QRUFLOg0KLS0NCjIuMjUuMQ0K
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
