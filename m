Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC104C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 01:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61C9C614A5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 01:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C9C614A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA0F36E98F;
	Tue, 11 May 2021 01:48:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 809706E98F
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 01:48:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4Ks7bNiTlXA3lpfVhKonoyLl4SEB+IpoRFa7XzP8JbRmP5804TrjnDlONGppy01ikXRI1gt4zS5daIOYAXukpuqGn97rsyJJKcvzYEmmZqiASbB1ABdsu+Tk8jAYXsgjK535Od+zii/hTopGsv4YrP0ltyX24pjVcl7WZzVhFGE0H9p212sRu+tzOnz/ab2CmzqsVwps9HLStieTRi8s6iRmOSa9QUHzncD60oGNZCW4kIOAG0gbVXUVjebkKi3vhhNAEf4ynZKLSgeYST71cM+QlGkBnRZ6poCQQbMv1DkY0PUdIy3U6/pp4xCrxLYlMupZNWVjZAJa9cgqElN4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZFyvR135uUBRixS+l+SoOjoo7lBX/LH6STCylyCK40=;
 b=UJwSCjWmfA9IVC2kY0doBG9OnJix4v/dqF+KQjAM1+0Ynvk1yDXpDg2XsTv3sbg+KK4Mxcem8XmTTZogGfF0qmyn6k6V+iEBuMBTAE5qbUo5khbmA1N+hS3V69Rk3I0i1f1Xc2M9rAg6MjmiiW4bwm/e/kIn65r0MZ/j+OstPEi/4umVfrsOpCZsIE41yCzntGM4b9SabFYue4CTlbwEs1MU68tjtakKVcdX9if+lYUFyzo94y8qDf5JQrcqZBKeLThJkC9U214cmzwPquXXMJco8zjIik1aaywf9sUVjlZpvoM810nLx7KCP+ZW4Tw22ZSysn0rE/wSKO5U4vMqzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZFyvR135uUBRixS+l+SoOjoo7lBX/LH6STCylyCK40=;
 b=zf/aPU61+nBciXwE5ZIE+kzINSDI/QNGmg4Bn5J6dEZ6Ha/nLVaJC7O7o9PX4A3N3GGnFJ5BsLbq2lsvO/ZnaLpUZu09M9L86pQG1AxSPNmU8ywn+pdyBZJqKIIz0iYC+Kbt/8cIPc4ddYGAefsxiR9lVl0Isi6VaHTiIp0jSrY=
Received: from DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11)
 by DM8PR12MB5464.namprd12.prod.outlook.com (2603:10b6:8:3d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 11 May
 2021 01:48:47 +0000
Received: from DM4PR12MB5374.namprd12.prod.outlook.com
 ([fe80::dd20:3f66:e06a:2297]) by DM4PR12MB5374.namprd12.prod.outlook.com
 ([fe80::dd20:3f66:e06a:2297%4]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 01:48:47 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 0/2] Use MTYPE_NC for coarse-grain remote memory
Thread-Topic: [PATCH 0/2] Use MTYPE_NC for coarse-grain remote memory
Thread-Index: AQHXRfU77HhUJ+GXvUat11wLuPZh3KrdQJiA
Date: Tue, 11 May 2021 01:48:47 +0000
Message-ID: <CDC1176A-2AB3-4C53-BE77-945BC2E66DCE@amd.com>
References: <20210510233528.1633-1-Felix.Kuehling@amd.com>
In-Reply-To: <20210510233528.1633-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.46.21021202
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d890e883-d099-419f-6ccb-08d9141eeb3b
x-ms-traffictypediagnostic: DM8PR12MB5464:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR12MB5464CC30C0CC39111D17648380539@DM8PR12MB5464.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A5gXY8bjnHkA10blFLatCeqSh7Gu0xi/cvVAdCILrjkI+VcbndXEPxReUVJXmANKhTcdDivRnTFZf+I87cpUq76rmMCrkY6G9BtrodYZut4QHXQwWamY8Z2qBCkzyVVnqSBePciUw4XenDNNNOvFYZZ10cHeCViVcDlcbd/gdq1xVlx3hqapo+p635gDh+DuUl0b/GfkUdbP8pLumPUGPEFnmmX0t+CexNPhPv5lghCDm+Yu4SBiRzLTE2Aa04terjDYclXs1xKFrjzjYBzSW484RSNBbBMZEGDJPDpIszi94GwlEv+3cFv/Cr6xS0j0QQ/BZnm5P3wZV9bh8JaiAQJffDKIJmBhQbFQOiNxBhgDQadzbr9CqUOptDwx4uQQ8PeK9OzAh5p+SQ332s461dX7tq9xJ8ftBGaFl6fBZlA3f6beYbWnfbCshdU+08eYqcePyxBa0/MvDFL2XodcF+F+zI4V3XBxhUpRsUQKEX4gF9YMYdPPmC6q3N+uPZlU8Sc5o3yJIjDVRB+MpX+crOmIuqPgCL+f69d0KK/j0U8yRSuhSACtmIV3epmnVbcqUEhDe7w8nQCdZUMEr9wlV/frmrStOL4XNvesmDZN4FNUa/59sRwAlO0KyNSUy4TbkpRByXsWSkVmtkDNnMANCbHCZJ6yS7W1XYDBpMZK+uVYeYciYtV9ybXRkLyT0M5f
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5374.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(66556008)(5660300002)(38100700002)(6512007)(64756008)(91956017)(76116006)(36756003)(8676002)(86362001)(8936002)(26005)(316002)(66446008)(33656002)(110136005)(2616005)(66946007)(4326008)(478600001)(45080400002)(6506007)(6486002)(966005)(71200400001)(2906002)(83380400001)(66476007)(186003)(122000001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?b0VXVDJjeFdPSllpRDJpSmttbEhPTjVDSDBlQk1kZ1VPQTcwQmJkcmxHUVJP?=
 =?utf-8?B?R3pjcXN0L0V3U1hWL2tHYVZHR1JPZndybFlBSXRBL1RyeGc2SHBoUUQ5TFN0?=
 =?utf-8?B?ejNxVXhrR2JxbVZWWHRyWkxvSHJYdlVoaWcvSnduZEF1SW05WUFIdkM4VXdW?=
 =?utf-8?B?Mm1lMHpUemxiWmlkUGgvMWFLSlp1cUdSYlNCcG5ZT3VHSnFVcTJVWmVMbGNG?=
 =?utf-8?B?K3NhN0c0dzlwNWpzNGlqOHFVcFVSaktqY3ZxeEJJUXE1ZW1hYWFTZXg0V2RT?=
 =?utf-8?B?UFJHem9yMFJsTlZBR0ZNL2tad0FUd1hsMEJsU3lkQnp5T095NTdVMHJyckVt?=
 =?utf-8?B?cVY2L29MbnpDa3JuMmhGOUloY3F0cHFiaVdxN29HRmZmYnk5NkU1YmtKV0lu?=
 =?utf-8?B?ek9zMUpNTVZ6Y1lscWVHZG15Ym0reS9mNDVoMjhxNXkxSWZtdmpMS3c1aXg5?=
 =?utf-8?B?SUdXd2cvUTVqam1EWkE1anR0WkhNdVJLcmJXekk2TU5xYXhFb2grVkw3a2sx?=
 =?utf-8?B?UFpYazVDcVZPSXZZQkViZ3gxWHlvWWl5dmVLeEV6c0pXSEgwM25BcnFDVWkw?=
 =?utf-8?B?cUN4OExwUmxEL0szTUxyaDNwNndXbGx2Y1ZvQ3lLem12clc0VGV3RVJUUWta?=
 =?utf-8?B?SzFYRUhLREc4SG0zb2dNSU9nREdOL2pKZ0lZTFZaNzJlQWZkRTV1WThBa1Vm?=
 =?utf-8?B?OE9jY2F5WG1mL1Y2NVQrWEJBZDlpZEp2a0ZwSEtYR0JBbU92RjV4SDRPVlJ0?=
 =?utf-8?B?S0hVbkJwNVlQb3dIOWYreUVuc1l5eFd5SGJQQmhhckxxQStWSGtnV3NiY28w?=
 =?utf-8?B?eCtCM1VuY1BBK3FSYzNwL0JWUVJTNitDUnR3eitjOXljYTVHR0JjcHcyQ0My?=
 =?utf-8?B?VWphZGZkR3NBV0FpK2xNYVhJNmhOSzJsREdCOXNXNmNRMHJiR0JrQlc1emR6?=
 =?utf-8?B?dFc4WTNoYTdqTllBZks3cU15YzVTVmpNNE1VN2pISTR3MjRpTDdkV1dVK1Jt?=
 =?utf-8?B?NldSMHorNDZ0YmpuRVZ1MitybWV1a0l2OXlRRjNDZGV0RDgvRVdLQWROa0R5?=
 =?utf-8?B?YURnMFVaSDdIQ1VRVmZFcXAvaWs1SVNqVHg1Unp4aC9PVUlBUnZtQnZzcjRy?=
 =?utf-8?B?VXl1SlQ0UGt3SDdDZEk2Y1p3ZVMvNml0U21McDFjVXpTNkgycFNyZ3k5bzFE?=
 =?utf-8?B?UnFzeEJkTnRGT0h0ay9BamtsNE5UZkJkNC9GaHh6aXYxRWJlaUNwWFRHQSta?=
 =?utf-8?B?ekJSSWM0ZmF4cTgwUkpaR3dyUXFOeVhlaGdCYlViZmdwdEZ5RzNvSW9KeWxk?=
 =?utf-8?B?WllZOTlVT29za2Y0cHZOdStkMXpXZzNwK0V4WURub0RCZC9LTWFkUmNFT2FM?=
 =?utf-8?B?MWF5SnVTZjUwTm9wVVBWYmpLeHdVdEdKZmp5OHFWSXFPSm9jd1FHZStOdkhu?=
 =?utf-8?B?Q1IzMHhqZW5PVk5qTVNCOTkwNXdTeCsxem9IdVcvK3JvcEZNQlNyNlptNnc0?=
 =?utf-8?B?ZU13WjRyVXMyWjRJN05Wck5uSnVMVGJpSTVGZDBwT3BJRnhhaTAwbmt4VDlu?=
 =?utf-8?B?akZGa2VVN2JGM0plU3dYRVMzUlBnSTVUbzVHaGRyU3d1SGJCdTVMNXcyQThT?=
 =?utf-8?B?RjdmWkgyRktpYUtuZGJJTWxEa2hDQkZtRXE3RHF5ZnhTZ2JDS0FwMngvQWx0?=
 =?utf-8?B?MGlCSzBvd3l0UjJ0bkw4eXBKbjlxVVpsSGNqUm0yNEVyZmVXWnhzT1IwRVUz?=
 =?utf-8?B?VTN0WmRhUGZ1RXZMNWd6Rnh0WEZRMmprdUdTb2Z0MzliMmxBcWVqaXdrc2ZO?=
 =?utf-8?B?TFZCM3VJVDVhY2s1WVBOZz09?=
Content-ID: <5E57C39F7A8111408E713728A6FF1BCD@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d890e883-d099-419f-6ccb-08d9141eeb3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 01:48:47.6336 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w5djtZyj51XX6Eouly45WnuddrI3RYoGFh5oQxgziBEjY/Z+n1uFKkGhsckIXxAk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5464
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
Cc: "Greathouse, Joseph" <Joseph.Greathouse@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBzZXJpZXMgaXMgUmV2aWV3ZWQtYnk6IE9hayBaZW5nIDxPYWsuWmVuZ0BhbWQuY29tPg0K
DQpSZWdhcmRzLA0KT2FrIA0KDQogDQoNCu+7v09uIDIwMjEtMDUtMTAsIDc6MzYgUE0sICJhbWQt
Z2Z4IG9uIGJlaGFsZiBvZiBGZWxpeCBLdWVobGluZyIgPGFtZC1nZngtYm91bmNlc0BsaXN0cy5m
cmVlZGVza3RvcC5vcmcgb24gYmVoYWxmIG9mIEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+IHdyb3Rl
Og0KDQogICAgVGhlc2UgcGF0Y2hlcyBhcmUgdGhlIHJlc3VsdCBvZiBkZWxpYmVyYXRpb25zIHdp
dGggbXVsdGlwbGUgQU1EIFNXIGFuZCBIVw0KICAgIHRlYW1zIHdpdGggdGhlIGdvYWwgb2YgaW1w
cm92aW5nIEFsZGViYXJhbiBwZXJmb3JtYW5jZSBhbmQgaGFybW9uaXppbmcgdGhlDQogICAgQXJj
dHVydXMgaW1wbGVtZW50YXRpb24gd2l0aCBpdC4NCg0KICAgIEZlbGl4IEt1ZWhsaW5nICgyKToN
CiAgICAgIGRybS9hbWRncHU6IEFyY3R1cnVzOiBNVFlQRV9OQyBmb3IgY29hcnNlLWdyYWluIHJl
bW90ZSBtZW1vcnkNCiAgICAgIGRybS9hbWRncHU6IEFsYmViYXJhbjogTVRZUEVfTkMgZm9yIGNv
YXJzZS1ncmFpbiByZW1vdGUgbWVtb3J5DQoNCiAgICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIHwgNiArKysrLS0NCiAgICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX3N2bS5jICAgICAgICAgICAgIHwgNiArKysrLS0NCiAgICAgMiBmaWxl
cyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCiAgICAtLSANCiAg
ICAyLjMxLjENCg0KICAgIF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fDQogICAgYW1kLWdmeCBtYWlsaW5nIGxpc3QNCiAgICBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KICAgIGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9v
ay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4l
MkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDQlN0MwMSU3Q29hay56ZW5nJTQwYW1kLmNv
bSU3Q2I2NDI5ZjBkYzcwODQ0NTMzNDc3MDhkOTE0MGM1YzkxJTdDM2RkODk2MWZlNDg4NGU2MDhl
MTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzU2Mjg2NTYwMTkwMjMwMyU3Q1Vua25vd24lN0NU
V0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklr
MWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT1FRUMySzQ2ZUFidFFPbjdwcGUl
MkI0ZnV4ZUU4clRhV0hOMnJxUEtrNFZ5R3clM0QmYW1wO3Jlc2VydmVkPTANCg0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
