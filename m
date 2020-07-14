Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096A8C433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 14:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C613C22510
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 14:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="K4imGGWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C613C22510
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 819F96E8B5;
	Tue, 14 Jul 2020 14:11:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28A176E8B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 14:11:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWnR5s3agsbNd1LT7MjiMHxrEoRepk9rjtiQ3sDLDMJkRAQyFvc7QY1Y8SzRxtamKREx4lFsJAtvCdCvjC8kegyTbwbPRNDcdnGErJd1TRc9bk5PxWvlRm9iN+ACYZqBvpEA7zuconDlJ6UAMQ+Vzd4kW9Hi18kn/Gk5XyOmUAgMsXFqBo0d8PK382mtNE3/mOzV15gSevbNTpvoHd/u23k2dWylUQoaWjqXaJQ2dcKTYiLZaYle+j5/jbHItSZKDeTM1cggTzXeYjZobEd+USfNGcd7ixNJbnky3RgkFnkgyCsNOJaWm9VIByReQ6bJe2cBPalkt1PyMqGjd3FemA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2T9mvWpXonNNsotCCMqr2m2D5cxAqbqk9kCSE2wG5A=;
 b=MI8QSsZe4pgIdYgszQ1/X59px9JiPFHXnhM0bz9QZ8ALjxSzVxJl8P00q3AJpXbLdjIPFOh6qIS/iwGY5TjMiDC7a/jp+5PRsPcbtTPMSTjVW3/Z9tv1Ej9lzvTAYG0NyamLAa2Jds9FXRQtB1ROn269r7ofvGx4KCpFjsJAHJw+zTEinQRhTHZq7OP6yjctTnlu7bn+CKiw0O2vu6NIaZiKThh/FB6oi2VbVn+N/XzWXF57gorZlO31RCv7QaEf2N2asFzM+jTqThZ6zko3QhVbXSEBhG73TooSApNb5KNJqG9ZVxjCh2gmoDR58S/lzppqfdy6FEAQm/p+kMNeag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2T9mvWpXonNNsotCCMqr2m2D5cxAqbqk9kCSE2wG5A=;
 b=K4imGGWbreZ9Bp466PBb12tiyZvO21bZi8Lv7JCHUFy/Bf4kinP4T1ww5uL0cDvOsZblE+Ze9RNVndoalcu9EJPDM6n7kxBWXR5FlwV7MD58he3x4IL4d7ZaDoHtxDxcA/xR3vNW23uyZcdhySnqCzJwBIoefFaa8zJRMk0bHwU=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM6PR12MB3147.namprd12.prod.outlook.com (2603:10b6:5:11d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 14:11:02 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::446f:752b:f450:e89a]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::446f:752b:f450:e89a%5]) with mapi id 15.20.3195.017; Tue, 14 Jul 2020
 14:11:02 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH UMR] Fix off-by-one error for decoding sdma linear write
 packet
Thread-Topic: [PATCH UMR] Fix off-by-one error for decoding sdma linear write
 packet
Thread-Index: AQHWWZXcB5dNk1f3HECt2caZaVyc0akHHfGv
Date: Tue, 14 Jul 2020 14:11:02 +0000
Message-ID: <DM6PR12MB35473F5ADE458B405E1F04FAF7610@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <20200714041830.29358-1-xiaojie.yuan@amd.com>
In-Reply-To: <20200714041830.29358-1-xiaojie.yuan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-14T14:11:02.144Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3337904d-f3e3-45be-c3ce-08d827ffbdd8
x-ms-traffictypediagnostic: DM6PR12MB3147:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3147EABDB093AD5365FA69ACF7610@DM6PR12MB3147.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:494;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QN9oIpAejBrY+JduzqQQBcPeE4jE2hM6AezktZB3wsOWkPBUlLekQOwP51hYSmxRC80hwCKCuOiADc9GYKxCUkvKQVxB37VCQ/fGl7ud77B3x7QXn5Y2jPLBFqnYM3LDnhUEHWplxMnHE//ubktU+AarZvnm1gBKJxpDInhMt/etGdzkW1QCnX4nBRkjzoxXOa2l+Q9frujDU1biQ/KiK593+waesEO0cFVgC1MIuRWW4/zS324iqUgQTqpp5etzX75mUD4VfI7U9r7wfa0/hhaJVBvYvHgC5m4217kXuISFPRToAGiiU37YS1ncVjdrQS5Xnx5RBSa5NCr/zOcs7A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(66946007)(52536014)(83380400001)(66446008)(76116006)(64756008)(66476007)(66556008)(91956017)(8676002)(478600001)(316002)(55016002)(110136005)(53546011)(5660300002)(8936002)(33656002)(7696005)(186003)(86362001)(26005)(9686003)(2906002)(6506007)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: LPUDLg2lJPPsT8GUsT6KyL7r4I9EVYs7HdhWlsUIr+nZfBdtSuXRLxZTJzL/AFPw2JmPNcMnfYuPnjjDJQ73ibgjgKiLTavaKP2NJxRSf7aj6URtgEW5brUGHvg/m9rPv417E30f4zySy86ORzQBZybbiHzRJ6hemFIwKoRX5Y0w4aztul7QQPbn3A9uCdY56XbITMT+v4GEjlheRUsRkckWwNtqL+hVNEsReGAMSytBPenaipB3t2HiqWuyRBikdUNy5/nfos1YAaauMG+Am3oTpJB6tc3bYQ52aP8rQ1QQqaQqovQ+og4WGk+jQUtwg0mb+kzHok9MNvH2sij7yjVB4XCCRahmG2Z5iucUSDAoVWkDZU3GlVd76QbYeR8uWc77P6qAcdEkS9V0C1HsLm+pZqpD1Az0aWVB570QlvlxL69Ws9w5GMx52NaMR/tECceMfGPMbCUY5XmSRb344K0RJrWUa5QJ9dAN/eMUPC4=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3337904d-f3e3-45be-c3ce-08d827ffbdd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 14:11:02.6209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yOEa3V8wCV0XV1qgcVz2ls/3hN0TY1uTE1SdF9upqlhOHmqyZ3wT00hbb13E8hZdFog02z3+4C/yZ/55aIUBsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3147
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Thanks, can you attach the patch to your email instead though so it applies cleanly?

Cheers,
Tom

________________________________________
From: Yuan, Xiaojie <Xiaojie.Yuan@amd.com>
Sent: Tuesday, July 14, 2020 00:18
To: amd-gfx@lists.freedesktop.org; StDenis, Tom
Cc: Yuan, Xiaojie
Subject: [PATCH UMR] Fix off-by-one error for decoding sdma linear write packet

COUNT in linear write packet represents dword number - 1

Before fix:
navi10.sdma0.ring[   0] == 0x00000002    .w. OPCODE: [WRITE], SUB-OPCODE: [0], LINEAR_WRITE
navi10.sdma0.ring[   1] == 0x00400a60    ... |---+ WORD [1]: DST_ADDR_LO: 0x00400a60
navi10.sdma0.ring[   2] == 0x00000000    ... |---+ WORD [2]: DST_ADDR_HI: 0x00000000
navi10.sdma0.ring[   3] == 0x00000000    ... |---+ WORD [3]: COUNT: 0x00000000
navi10.sdma0.ring[   4] == 0xdeadbeef    ...

After fix:
navi10.sdma0.ring[   0] == 0x00000002    .w. OPCODE: [WRITE], SUB-OPCODE: [0], LINEAR_WRITE
navi10.sdma0.ring[   1] == 0x00400a60    ... |---+ WORD [1]: DST_ADDR_LOa: 0x00400a60
navi10.sdma0.ring[   2] == 0x00000000    ... |---+ WORD [2]: DST_ADDR_HIb: 0x00000000
navi10.sdma0.ring[   3] == 0x00000000    ... |---+ WORD [3]: COUNTc: 0x00000000
navi10.sdma0.ring[   4] == 0xdeadbeef    ... \---+ WORD [4]: DATA: 0xdeadbeef

Signed-off-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
---
 src/lib/ring_decode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/lib/ring_decode.c b/src/lib/ring_decode.c
index c3b5d18..a74229d 100644
--- a/src/lib/ring_decode.c
+++ b/src/lib/ring_decode.c
@@ -1819,7 +1819,7 @@ static void parse_next_sdma_pkt(struct umr_asic *asic, struct umr_ring_decoder *
                                                case 2: printf("DST_ADDR_HI: %s0x%08lx%s", YELLOW, (unsigned long)ib, RST);
                                                        break;
                                                case 3: printf("COUNT: %s0x%08lx%s", BLUE, (unsigned long)ib, RST);
-                                                       decoder->sdma.n_words += ib - 1;
+                                                       decoder->sdma.n_words += ib;
                                                        break;
                                                default: printf("DATA: %s0x%08lx%s", BLUE, (unsigned long)ib, RST);
                                                        break;
--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
