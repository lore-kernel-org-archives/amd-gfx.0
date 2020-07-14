Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255EFC433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 15:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAB7C22285
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 15:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hmlKgwi1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB7C22285
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD6696E8A8;
	Tue, 14 Jul 2020 15:35:50 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770088.outbound.protection.outlook.com [40.107.77.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 096716E8A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 15:35:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JisKwLgKvlGbOY8zGKcsxacRCUU6gWvRKDdAVvRErAGuwJPKLJXVW4QYXnNb85V7SUdNMI5LtPT4ScA6BjU4FgJru9aknBkp+75Vm1c5vMC101K8ffc/SUpk1IDWLJFIIZDBdZUsTqSBXM9uPoW5bB1yYphl8QP1F7cpfE0vJDZSg88WLzfAnwi737YdhPijvkrouQ0nrjwUIAXJ1+JIKuvTF/jJ+gFFSFI/Lp3XwzI8ZYGMcS934mj8kCYhygxD8w0ZQehs9x5ZMo2ry0yxgUlhZ1R9LXw+ptLkL7NCOSQ8XUdzOBbAlEi3RlC55UIUGP6T6RHwSyyvICmBXL1zDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YInG+wVdLLlji5a22RSfZNL6XmOgkmB6qwxvD+jTr8=;
 b=Rr0/B0vLyWxkJq4YPYiyPCCX5e1u07yRts/a/3MMKfTnijIcRZe4kNJONcLr4rg2eSqbaCo6L3uTO0nxj3ZIrJ16uLUsrnrTtQqgW48GjaqLyILk25hx1QRQHX0a+3rsu2m/HUYE4bB/1DaA832DiwxmSVLtSWSM2Us5dap+KYtXDFwPU8z3OT9A0CRfXdujgOd0Yc4hPxvJ0MJ0nWZMg4fpAExbNfjlROLF0d8b5a8fkkAqwj21KMSv4lNo+Cn5A93ZATmJjAKnrTqqA7erIFemYYBIRG+i3L5PsiewLGh4rysKGWEL0GHPTqSQQjFi8KcgiOD0NKAtlFj/id86mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YInG+wVdLLlji5a22RSfZNL6XmOgkmB6qwxvD+jTr8=;
 b=hmlKgwi1tagbwrIndbPCy8NpUa2JQUxzeZx3kStqNLhMYqvaA+CavUkYg4HEqgqXzC2WWDBXttdgGKSVunTi2Cf5F/Ozoun0CAP9rfXNVt4In3b/SJ1ZAfefxu9RnfAChG19I/pKEu+3pO/bRK9HacpKyS5yPafndJqDeWe88TY=
Received: from MW2PR12MB2586.namprd12.prod.outlook.com (2603:10b6:907:11::21)
 by MWHPR12MB1376.namprd12.prod.outlook.com (2603:10b6:300:13::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 15:35:46 +0000
Received: from MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::693d:7e71:3a0d:b6d4]) by MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::693d:7e71:3a0d:b6d4%7]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 15:35:46 +0000
From: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
To: "StDenis, Tom" <Tom.StDenis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH UMR] Fix off-by-one error for decoding sdma linear write
 packet
Thread-Topic: [PATCH UMR] Fix off-by-one error for decoding sdma linear write
 packet
Thread-Index: AQHWWZXbqYeY/rNEe0Ce3NKe3Eq3iakHHgoAgAAXUbo=
Date: Tue, 14 Jul 2020 15:35:46 +0000
Message-ID: <MW2PR12MB2586140707DD884C1FE54E5B89610@MW2PR12MB2586.namprd12.prod.outlook.com>
References: <20200714041830.29358-1-xiaojie.yuan@amd.com>,
 <DM6PR12MB35473F5ADE458B405E1F04FAF7610@DM6PR12MB3547.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB35473F5ADE458B405E1F04FAF7610@DM6PR12MB3547.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-14T15:35:45.959Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e67dd482-d44f-4d3b-58d0-08d8280b941f
x-ms-traffictypediagnostic: MWHPR12MB1376:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1376E0210D740D348CA92D6189610@MWHPR12MB1376.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:568;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OJDH5Bthq9SC4/1gpTezCAu8fs36fdTiKAAO8BNsfeStskWRUtCApfsluN5D+J0apeXTZ/kPuOR1i2ttDk5OMmH4C/FXYehFGWoGgZ4q8fFYsrcu28D0sg+HfnWebauTDe1VTThx4c9DYEBTulZE4X2JbCkNcqvThRbV65nmbKjs/7cpQgLkautW3IRR9bQRoInomzUYUXLEmos405RzrMrqoSY36ysbx8YEK1CMWoyAEXiIG68pxZ5Q7DPi+/ECUuwdZgXMD6rblNcgoDsiyyiLoGX4LS/mEtOXKdW0U+EwHWURk5HHoFoq2ZCIkiTE/giOrzv44bqJs75vGvFuHw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2586.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(6506007)(53546011)(7696005)(2906002)(33656002)(478600001)(66616009)(76116006)(64756008)(66946007)(91956017)(316002)(110136005)(66446008)(66556008)(66476007)(71200400001)(8676002)(86362001)(8936002)(83380400001)(99936003)(52536014)(5660300002)(9686003)(26005)(186003)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: gjZTpKsC75sNlbp7wdnVUKhnYbwWkx4UgvzThtktP04mYEIUZgbVU2PP4+sfQa/1xuhBrL997FRN6m7dzu7ar9T/5ZS1AGHsqVawZbVxcD6SjlDdiJd/dGWKRpJ0CG+VNdNUSnkGHd2LS3+aCsHI20+iD7pYPf2dBAcL+/hXLttDs4jpC0LxepMRtNDo8NCrZfxPvIxLn7NMO/vm5Pg0KjkZtwZresHEY08hVGjGsRRFnlqybjGYofGPaF6RZyUlWC+ZxjTmIXwX0P88YPQWnqf3m2fFEjsqkKrWcUhR+PcP5ZOEf3ynA5HgzVrjkFkSSAvmt8I2Of7NS9ycp4OzQ3Ev4e9chM6ll9F0y5w4rMqNgn2LNvvimW1LLTt+OEwnKYtZAfxEUFN2zT02nGYZAz3BSp2rEUPjs1jVOVL/swtCt9K+HWDRu59KNR9u4yN6Fdr6NTeJXCGso0UYQLS1/JZCMJ5s/03YYHZKGMjiJQ0=
Content-Type: multipart/mixed;
 boundary="_002_MW2PR12MB2586140707DD884C1FE54E5B89610MW2PR12MB2586namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2586.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67dd482-d44f-4d3b-58d0-08d8280b941f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 15:35:46.6749 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1nka6VzyXmZtPibeRXBeWFRgexSwRpYb2++Jn0YKMQyd9Qvi0PZEZtbiBK8o3N8r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1376
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

--_002_MW2PR12MB2586140707DD884C1FE54E5B89610MW2PR12MB2586namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Sure Tom, here it is.

BR,
Xiaojie

________________________________________
From: StDenis, Tom <Tom.StDenis@amd.com>
Sent: Tuesday, July 14, 2020 10:11 PM
To: Yuan, Xiaojie; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH UMR] Fix off-by-one error for decoding sdma linear writ=
e packet

[AMD Official Use Only - Internal Distribution Only]

Thanks, can you attach the patch to your email instead though so it applies=
 cleanly?

Cheers,
Tom

________________________________________
From: Yuan, Xiaojie <Xiaojie.Yuan@amd.com>
Sent: Tuesday, July 14, 2020 00:18
To: amd-gfx@lists.freedesktop.org; StDenis, Tom
Cc: Yuan, Xiaojie
Subject: [PATCH UMR] Fix off-by-one error for decoding sdma linear write pa=
cket

COUNT in linear write packet represents dword number - 1

Before fix:
navi10.sdma0.ring[   0] =3D=3D 0x00000002    .w. OPCODE: [WRITE], SUB-OPCOD=
E: [0], LINEAR_WRITE
navi10.sdma0.ring[   1] =3D=3D 0x00400a60    ... |---+ WORD [1]: DST_ADDR_L=
O: 0x00400a60
navi10.sdma0.ring[   2] =3D=3D 0x00000000    ... |---+ WORD [2]: DST_ADDR_H=
I: 0x00000000
navi10.sdma0.ring[   3] =3D=3D 0x00000000    ... |---+ WORD [3]: COUNT: 0x0=
0000000
navi10.sdma0.ring[   4] =3D=3D 0xdeadbeef    ...

After fix:
navi10.sdma0.ring[   0] =3D=3D 0x00000002    .w. OPCODE: [WRITE], SUB-OPCOD=
E: [0], LINEAR_WRITE
navi10.sdma0.ring[   1] =3D=3D 0x00400a60    ... |---+ WORD [1]: DST_ADDR_L=
Oa: 0x00400a60
navi10.sdma0.ring[   2] =3D=3D 0x00000000    ... |---+ WORD [2]: DST_ADDR_H=
Ib: 0x00000000
navi10.sdma0.ring[   3] =3D=3D 0x00000000    ... |---+ WORD [3]: COUNTc: 0x=
00000000
navi10.sdma0.ring[   4] =3D=3D 0xdeadbeef    ... \---+ WORD [4]: DATA: 0xde=
adbeef

Signed-off-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
---
 src/lib/ring_decode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/lib/ring_decode.c b/src/lib/ring_decode.c
index c3b5d18..a74229d 100644
--- a/src/lib/ring_decode.c
+++ b/src/lib/ring_decode.c
@@ -1819,7 +1819,7 @@ static void parse_next_sdma_pkt(struct umr_asic *asic=
, struct umr_ring_decoder *
                                                case 2: printf("DST_ADDR_HI=
: %s0x%08lx%s", YELLOW, (unsigned long)ib, RST);
                                                        break;
                                                case 3: printf("COUNT: %s0x=
%08lx%s", BLUE, (unsigned long)ib, RST);
-                                                       decoder->sdma.n_wor=
ds +=3D ib - 1;
+                                                       decoder->sdma.n_wor=
ds +=3D ib;
                                                        break;
                                                default: printf("DATA: %s0x=
%08lx%s", BLUE, (unsigned long)ib, RST);
                                                        break;
--
2.20.1


--_002_MW2PR12MB2586140707DD884C1FE54E5B89610MW2PR12MB2586namp_
Content-Type: text/x-patch;
	name="0001-Fix-off-by-one-error-for-decoding-sdma-linear-write-.patch"
Content-Description:  0001-Fix-off-by-one-error-for-decoding-sdma-linear-write-.patch
Content-Disposition: attachment;
	filename="0001-Fix-off-by-one-error-for-decoding-sdma-linear-write-.patch";
	size=1865; creation-date="Tue, 14 Jul 2020 15:34:41 GMT";
	modification-date="Tue, 14 Jul 2020 15:34:41 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyNjljNWRiYTU2NzU1M2FkODhhZTk2ZDFkM2IwOThjM2MzMzFjZjM1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBYaWFvamllIFl1YW4gPHhpYW9qaWUueXVhbkBhbWQuY29tPgpE
YXRlOiBUdWUsIDE0IEp1bCAyMDIwIDEyOjEzOjA0ICswODAwClN1YmplY3Q6IFtQQVRDSF0gRml4
IG9mZi1ieS1vbmUgZXJyb3IgZm9yIGRlY29kaW5nIHNkbWEgbGluZWFyIHdyaXRlIHBhY2tldAoK
Q09VTlQgaW4gbGluZWFyIHdyaXRlIHBhY2tldCByZXByZXNlbnRzIGR3b3JkIG51bWJlciAtIDEK
CkJlZm9yZSBmaXg6Cm5hdmkxMC5zZG1hMC5yaW5nWyAgIDBdID09IDB4MDAwMDAwMDIgICAgLncu
IE9QQ09ERTogW1dSSVRFXSwgU1VCLU9QQ09ERTogWzBdLCBMSU5FQVJfV1JJVEUKbmF2aTEwLnNk
bWEwLnJpbmdbICAgMV0gPT0gMHgwMDQwMGE2MCAgICAuLi4gfC0tLSsgV09SRCBbMV06IERTVF9B
RERSX0xPOiAweDAwNDAwYTYwCm5hdmkxMC5zZG1hMC5yaW5nWyAgIDJdID09IDB4MDAwMDAwMDAg
ICAgLi4uIHwtLS0rIFdPUkQgWzJdOiBEU1RfQUREUl9ISTogMHgwMDAwMDAwMApuYXZpMTAuc2Rt
YTAucmluZ1sgICAzXSA9PSAweDAwMDAwMDAwICAgIC4uLiB8LS0tKyBXT1JEIFszXTogQ09VTlQ6
IDB4MDAwMDAwMDAKbmF2aTEwLnNkbWEwLnJpbmdbICAgNF0gPT0gMHhkZWFkYmVlZiAgICAuLi4K
CkFmdGVyIGZpeDoKbmF2aTEwLnNkbWEwLnJpbmdbICAgMF0gPT0gMHgwMDAwMDAwMiAgICAudy4g
T1BDT0RFOiBbV1JJVEVdLCBTVUItT1BDT0RFOiBbMF0sIExJTkVBUl9XUklURQpuYXZpMTAuc2Rt
YTAucmluZ1sgICAxXSA9PSAweDAwNDAwYTYwICAgIC4uLiB8LS0tKyBXT1JEIFsxXTogRFNUX0FE
RFJfTE86IDB4MDA0MDBhNjAKbmF2aTEwLnNkbWEwLnJpbmdbICAgMl0gPT0gMHgwMDAwMDAwMCAg
ICAuLi4gfC0tLSsgV09SRCBbMl06IERTVF9BRERSX0hJOiAweDAwMDAwMDAwCm5hdmkxMC5zZG1h
MC5yaW5nWyAgIDNdID09IDB4MDAwMDAwMDAgICAgLi4uIHwtLS0rIFdPUkQgWzNdOiBDT1VOVDog
MHgwMDAwMDAwMApuYXZpMTAuc2RtYTAucmluZ1sgICA0XSA9PSAweGRlYWRiZWVmICAgIC4uLiBc
LS0tKyBXT1JEIFs0XTogREFUQTogMHhkZWFkYmVlZgoKU2lnbmVkLW9mZi1ieTogWGlhb2ppZSBZ
dWFuIDx4aWFvamllLnl1YW5AYW1kLmNvbT4KLS0tCiBzcmMvbGliL3JpbmdfZGVjb2RlLmMgfCAy
ICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9zcmMvbGliL3JpbmdfZGVjb2RlLmMgYi9zcmMvbGliL3JpbmdfZGVjb2RlLmMKaW5k
ZXggYzNiNWQxOC4uYTc0MjI5ZCAxMDA2NDQKLS0tIGEvc3JjL2xpYi9yaW5nX2RlY29kZS5jCisr
KyBiL3NyYy9saWIvcmluZ19kZWNvZGUuYwpAQCAtMTgxOSw3ICsxODE5LDcgQEAgc3RhdGljIHZv
aWQgcGFyc2VfbmV4dF9zZG1hX3BrdChzdHJ1Y3QgdW1yX2FzaWMgKmFzaWMsIHN0cnVjdCB1bXJf
cmluZ19kZWNvZGVyICoKIAkJCQkJCWNhc2UgMjogcHJpbnRmKCJEU1RfQUREUl9ISTogJXMweCUw
OGx4JXMiLCBZRUxMT1csICh1bnNpZ25lZCBsb25nKWliLCBSU1QpOwogCQkJCQkJCWJyZWFrOwog
CQkJCQkJY2FzZSAzOiBwcmludGYoIkNPVU5UOiAlczB4JTA4bHglcyIsIEJMVUUsICh1bnNpZ25l
ZCBsb25nKWliLCBSU1QpOwotCQkJCQkJCWRlY29kZXItPnNkbWEubl93b3JkcyArPSBpYiAtIDE7
CisJCQkJCQkJZGVjb2Rlci0+c2RtYS5uX3dvcmRzICs9IGliOwogCQkJCQkJCWJyZWFrOwogCQkJ
CQkJZGVmYXVsdDogcHJpbnRmKCJEQVRBOiAlczB4JTA4bHglcyIsIEJMVUUsICh1bnNpZ25lZCBs
b25nKWliLCBSU1QpOwogCQkJCQkJCWJyZWFrOwotLSAKMi4yMC4xCgo=

--_002_MW2PR12MB2586140707DD884C1FE54E5B89610MW2PR12MB2586namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_002_MW2PR12MB2586140707DD884C1FE54E5B89610MW2PR12MB2586namp_--
