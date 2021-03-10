Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30516C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 02:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E174D64FA0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 02:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E174D64FA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8715F6E17B;
	Wed, 10 Mar 2021 02:39:29 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760055.outbound.protection.outlook.com [40.107.76.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4CF66E17B
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 02:39:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpFVVzmnIujq3Tzp7Gg4BdaLW5om2F2ouPyOYaNtwaVCdcQ2DmSwM0Dgd7yb97vz4dH4I5/r7dGiOIZwE1pCkbwyS1IRJiDa5CBstHLLqal2Q6yJit5j8Kkv4newPTCZHbmC6c8IMBokMlaaMXTD4XrTEcO0x+YT9kA/C7/HFetMQt/zuz2K+FfmyQuH8zdrSHvkiNcr3TsAujFpWCcDYhR2sqiSm1T5iIwksyFKbVTCGD4b0WGvBkoorKD5OvzJET8cJj1juHBhjSaaSkzjPdDKnwiNQ1+tdqQMkjMp5ZfwFlRM+bQPwVZHwCaUuvg+htEf4hLCvwr784WZJHlNag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQM5f9QcSm6ID5aXVVxizI3NHKNOC+7gLn2MJI8ie5I=;
 b=Vrqt/EF13h0Vmnh7dT0khoYMjmjCBapuXbTk9iWlcX/7MmLFZAQJ8FfTqjuJt3HUyQ8GS7Jx2ugWBVjkWGrVwsSYLxYDWQi+P5TraE2PsCbPqdZVr1oO+1BCWkJcpFs7ECXPFn0bouhS0p+YGVm6WynLxkz82KZuXEYoZLjx5qSvKXEzktPkpkD3WT4eyKwjlBWq1qMzA8simp1qddSerBm4KaM5i6rTs8rRpMFAVj7yyHn82D+xBvVw7Z/Ko6sAMr53k+tM3L70Rhuw68O43lMJEuMISefciCCCL/4PiOx3Ez6rBx9/h5/F0X3OINRTgnN5zbOABFKUaNpa+AMNww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQM5f9QcSm6ID5aXVVxizI3NHKNOC+7gLn2MJI8ie5I=;
 b=EJF8/QiWsP71SsjXAr3FzrVEf3bWRV0mfQpoI7GaslfpOj7ruRN4ddcvlhZE/tdKD+mp/s5sHQyKbchC7J8awTY+eeRUeJKzqZmE4C0Orz68Wpy3xIMy35VHxGyudWrfKWCZnn+kIMYfyCWHaKDeJkHAF78+jcAdUApAyWNID58=
Received: from DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11)
 by DM5PR1201MB0123.namprd12.prod.outlook.com (2603:10b6:4:50::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 02:39:27 +0000
Received: from DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70]) by DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70%6]) with mapi id 15.20.3890.038; Wed, 10 Mar 2021
 02:39:27 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: skip read eeprom for device that pending on
 XGMI reset
Thread-Topic: [PATCH] drm/amdgpu: skip read eeprom for device that pending on
 XGMI reset
Thread-Index: AQHXFUx8ypDUQD3qy0SBi5SG/x16w6p8gntw
Date: Wed, 10 Mar 2021 02:39:26 +0000
Message-ID: <DM6PR12MB460387275DD5F889F71982BAFE919@DM6PR12MB4603.namprd12.prod.outlook.com>
References: <20210310012640.2380-1-shaoyun.liu@amd.com>
In-Reply-To: <20210310012640.2380-1-shaoyun.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-10T02:39:14Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0e63a332-b005-4930-80b3-3a9c72d6e70f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 425ef2d4-44a8-4267-ef35-08d8e36db92e
x-ms-traffictypediagnostic: DM5PR1201MB0123:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB012333D665AE67B4DD8DA470FE919@DM5PR1201MB0123.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9l63BsG+RqM1G3sxKPJNXyueqSGFMk2ciqfmTds0GnCNJBX6C7AEJfLOUE72WusvnqJTDdu7gH1RAbuopR4LeOa1Es8KxtKq0QXhY7e6U2GLXqzkwMjV96TGsLaqU5PNEA5D40BY3tiMYgeZL4nAqBL8fGJIdGTpz729qoz+ctpvKbIF7T+0liGaay5uw4bXYcNVKZsrjIWG5jEUdYqkqi6rwEht63Zej6zqKanG5LvVuLgNvatb/vY9xxZuQqUUNkjXPB/ZeddYCR7BtF44VVQm3lZT+cfLUNSUA7ix6JBi06x+3lFNFRlLl/CPLJqnA8tSbcQS6PNvkUYSUXuPTLAT5cp27W6zj2k0ybAyGOducGgFd+Y7QfQAoCmHol0330odelUigMFGqW0gry8VL8OSqJpth0qJIntnuN3gbOLguPUyk/LcSb7PySxUI6RsTnHlx17csPhbEKr0e/8a4LOR4CmBc+wOD+5GZTE4Jv35yeZohItQ4iDloj2YGq5nutvgUYfXm2QPomMbSI9GkOU3JCedr6oDSv1oiRI6LRAnUPogHIYU+7FEP13AvhqT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4603.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(33656002)(9686003)(52536014)(5660300002)(7696005)(110136005)(66446008)(64756008)(2906002)(6506007)(966005)(8936002)(55016002)(45080400002)(66556008)(71200400001)(83380400001)(8676002)(186003)(76116006)(66946007)(478600001)(316002)(66476007)(4326008)(86362001)(26005)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?gb2312?B?R1M1cEJNNy95ZXQzRXhpNFJhYXhjdWwxYkdsL0dLTVFxQlVKdTR2S29QVHNm?=
 =?gb2312?B?YXp1MjRqeHpYazZrN202MVVGL05LRmJLTWJKRUFSR2tnaVVYZWhhZHMyMVJY?=
 =?gb2312?B?QXgwOTc0d2F0YWxJanVRRU0wY3lqVTR4aGFKc2ZPOExEeGFTY0g0NFhnNzda?=
 =?gb2312?B?enlSNXovZmlhdzhCekpOdXR1THcyY04wMjVEeEpoQ3d5Y1RJZnA1M1EwT3Nh?=
 =?gb2312?B?Qk5oOVMwbEtxQ281VU8xNldkUVpHaXo3cmlWQW5FaTYwTjZrT2NSSjFJajVD?=
 =?gb2312?B?dFlYVHREYlNzcTYxUFBsQktSVlg3cHFyWVlWbHhoYUJtZjBjMXpRYkhzUFla?=
 =?gb2312?B?S011VWhEMExXek9zNG93M1EwVHh6MXpobUphWUQraTN1dEdKK2FzcXhDRnRY?=
 =?gb2312?B?WitBeHlyZkFsK2M1SStUMlkrWWJva2ZraVFQQkpHTmpkQ01LelJrQWpBdnlR?=
 =?gb2312?B?ck5QVm1DV3lmb1dYUHZ3anByeWJDWVYxa2hpSmhLc1ZpNjQyMW14NXlvejds?=
 =?gb2312?B?dENhZTdXcDNsNlVJMGNvaFU2UEVrSThKL2pjbVJSQnJsRGZSd1ZtdHpLTFJH?=
 =?gb2312?B?VUQ3VnM0N2FZY0E1SzBpejlxRTVIZmdRQldXbzd4WXkrUndJSCtjem8yUmZx?=
 =?gb2312?B?d0RzRnBlUFFxZ1llZ2s3VWdwUnQ1S2prQktSQ3JVOFUxdURTSVJRUFFNbUhR?=
 =?gb2312?B?azJxd0c0UHFScjJMbkh4UmxRWjJpRDdQalBJQ2phZnZmbzcwSitrYjlVN3JS?=
 =?gb2312?B?NnRJbUNoVVdwL2dYNGFIaXo3eU1wNVZIT3NFd1V3OWtaNldMRDJMM1VOejBz?=
 =?gb2312?B?bVR3eFZZWDNQUEl4ZjgwZFBpbWJYekI3L2xVVENkSnJxSWd5RmFSazROYmY2?=
 =?gb2312?B?ckhFQzdhVnJBd3NXL2REWit4Smx6SHlteHYyWkw1NzlMZ1RiZVBLSVNDYVBY?=
 =?gb2312?B?cmQ0YzdtbUVsUXBDTVJzYTl1VkZPcWhXNytOc1NhTWZhcTd2QmxqRkJrU25E?=
 =?gb2312?B?YmxGUUtLRjlDaVZpOFFnZUtJWmI1VTRKWXZXK0tMaWlqZXFvL3JWVlFCM1hx?=
 =?gb2312?B?d3lWZGowWGJXVlkycytqZEFLb0tCMnkzbXhlZDQ3YTZBNUM0Q3JYdTI2UHhu?=
 =?gb2312?B?L2ZMR0N1UkU1T0tuMWFMZ3Z4YjlFSG15SmVhbGNwM1dZTTlrM3lkaDdDWGpO?=
 =?gb2312?B?eXFTVE0yc3RWdm1UWkhhSkVyck1CMTBsMzlsVmxuVFNVWWNnYXQ4OUZ4SUNS?=
 =?gb2312?B?MzZidDA2VWpldy9NenZhcmVveEZRSVN3Z0FvRjBPeTRjdk5jay81MDg0RC9j?=
 =?gb2312?B?cE1USzFCRHJjNjM5eWdGWW11NFR0SGFuYTRERitjNFQ3NVNVKzF3MjRscHVW?=
 =?gb2312?B?b0RESHk2VWdwT0VQNktEcXNzTFMrN0pDS3VvRklxR1lhTjhwZGk2KzEydUJu?=
 =?gb2312?B?Z2Y1YWRFN0RqVlZHa0l1cTE3U3pCY3NERSt4T0dmZks0bml2OUxlYlh0Q3BE?=
 =?gb2312?B?eDdFQ3U3SGFFWHErZ3c5bDhmVUxUbUxjcDNPQWlQalNSNGUxSWZpL1VxUmx6?=
 =?gb2312?B?cDFoVjhhMHB2Zm5iSG1scmJiQzVGVmEwMWlNVUx5aXdsZC9Kelp2WmtPL1ZR?=
 =?gb2312?B?K3NJcG1QdG45dWd5a2djM1JZaFVVTjI4Y01lY1dYREtPS0laU3M4N0VkTFRP?=
 =?gb2312?B?akhsbllic3cybEhMejY1TXVqMWl1TFc5aUJmNG1Qb25FWm50dUFwcGdiZ242?=
 =?gb2312?Q?pVYUcHc26ZjrdD2JDAEUuMVBSKcfH3ouFcnTq3X?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425ef2d4-44a8-4267-ef35-08d8e36db92e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 02:39:26.9427 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iU/NKfQ+dAYxmj11rph6L1KpuYK3DGUwRAWWMLiLE9jJ8LpkVvPok19yOC7IJwqH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0123
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
Cc: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQoN
Cg0KUmV2aWV3ZWQtYnk6IEZlaWZlaSBYdSA8RmVpZmVpLlh1QGFtZC5jb20+DQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2Ygc2hhb3l1bmwNClNlbnQ6IDIwMjHE6jPUwjEw
yNUgyc/O5yA5OjI3DQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBMaXUs
IFNoYW95dW4gPFNoYW95dW4uTGl1QGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRn
cHU6IHNraXAgcmVhZCBlZXByb20gZm9yIGRldmljZSB0aGF0IHBlbmRpbmcgb24gWEdNSSByZXNl
dA0KDQpSZWFkIGVlcHJvbSB0aHJvdWdoIFNNVSBkb2Vzbid0IHdvcmtzIHN0YWJsZSBvbiBYR01J
IHJlc2V0IGR1cmluZyB0ZXN0Lg0Kc2tpcCBpdCBmb3Igbm93DQoNClNpZ25lZC1vZmYtYnk6IHNo
YW95dW5sIDxzaGFveXVuLmxpdUBhbWQuY29tPg0KQ2hhbmdlLUlkOiBJZDg2NGI5NmE5ZGE1YjBk
NGRkNWZmZWY5ODU4OTk3ZGQ5ZjUyZGUyNQ0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Jhcy5jIHwgNiArKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25z
KCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFz
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCmluZGV4IGM2Njk0
MzVjY2M3NC4uYTJhYjhlZTI1MWYxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Jhcy5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcmFzLmMNCkBAIC0xODIyLDYgKzE4MjIsMTIgQEAgaW50IGFtZGdwdV9yYXNfcmVjb3Zlcnlf
aW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCiAJCQlnb3RvIG91dDsNCiAJfQ0KIA0K
KwkvKiBUb2RvOiBEdXJpbmcgdGVzdCB0aGUgU01VIG1pZ2h0IGZhaWwgdG8gcmVhZCB0aGUgZWVw
cm9tIHRocm91Z2ggSTJDDQorCSAqIHdoZW4gdGhlIEdQVSBpcyBwZW5kaW5nIG9uIFhHTUkgcmVz
ZXQgZHVyaW5nIHByb2JlIHRpbWUNCisJICogKE1vc3RseSBhZnRlciBzZWNvbmQgYnVzIHJlc2V0
KSwgc2tpcCBpdCBub3cNCisJICovDQorCWlmIChhZGV2LT5nbWMueGdtaS5wZW5kaW5nX3Jlc2V0
KQ0KKwkJcmV0dXJuIDA7DQogCXJldCA9IGFtZGdwdV9yYXNfZWVwcm9tX2luaXQoJmNvbi0+ZWVw
cm9tX2NvbnRyb2wsICZleGNfZXJyX2xpbWl0KTsNCiAJLyoNCiAJICogVGhpcyBjYWxsaW5nIGZh
aWxzIHdoZW4gZXhjX2Vycl9saW1pdCBpcyB0cnVlIG9yDQotLSANCjIuMTcuMQ0KDQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KYW1kLWdmeCBtYWlsaW5n
IGxpc3QNCmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpodHRwczovL25hbTExLnNhZmVs
aW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVl
ZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTA0JTdD
MDElN0NGZWlmZWkuWHUlNDBhbWQuY29tJTdDMDI3NmExZGYyNTM3NDkwM2E2NzIwOGQ4ZTM2Mzk4
MzIlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3NTA5MzY0
Mjc0NDQxNjM0JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENK
UUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzEwMDAmYW1wO3Nk
YXRhPTR4N1c0JTJGTHpUYjhuS2tyeUhDV3IlMkJ4JTJCTG1FdEZ3YXg2bFpxN1MzRVdyOEUlM0Qm
YW1wO3Jlc2VydmVkPTANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
