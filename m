Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AB6C2D0E2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 13:12:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61EF22396D
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 13:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZYnFHt20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EF22396D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97A4D897E0;
	Tue, 22 Sep 2020 13:12:56 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750082.outbound.protection.outlook.com [40.107.75.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D96F4897E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 13:12:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/fa9DtsBDo3Ogqr8BK4u+bpqXHBhXMDTUbrMKYudtVHezfWsL+fOLqfX73e7aPtVPYqAK7OGaDDBzehxhKaIFxvUS14mnj9nNxy6vjWd2GmbVUzWQUbFbP3u3GuvybLoZgl2yNBQvn5qGi/quBg0NlxuE9jKRQmuGDbDsunjub1GJ2k9OTJcrLithGQmp0DFcmB8HrMAImyw8zbm+apkkSKa2bvB5t1AXnaDwKUGjZt6Ptuwx/bK5T2DagLLZrRxh7YlgLV3SxeLU2VRvpxFjW1gnfxVchAu3sti9KPcT1PfgNGx5vp/JCNel2Jr9qRoS9uwIwFgNSJFUmeCM/DnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SB7TTZG0uu8LweaxWCYwnHB98vjkE6TlX0L6zcSqkNo=;
 b=F/aJor2wBiimiXysJCgFYsXD9f6d4+McFjoJ05g5nDecjMwx24mJMZdIsDPfhzr4BCPvMDabHgo72TvjuKScYqfrbbHsLAEviXTgROb2Y/vfjavgJ4i4cutmX5t02rxrfoHjipW+bNob/FdjbbMOhv2fPeTsE/e0rtOUHi6IqS7ABHB+i+7xeO4pLzwe5PZlhbLbagBSiGliGUmukskJemip2c+7OprueR3JMShSoAt5kL9aVfCUXxBnELwh16qfU7/9aYh5gs0Gero6znu9amypuFUJD75MftQEIe60PXu5OUCHnkLSeliFsqZu68pxWwKgWn8+wN4QCMmeUpA2Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SB7TTZG0uu8LweaxWCYwnHB98vjkE6TlX0L6zcSqkNo=;
 b=ZYnFHt20wPNg7a7V2E+4mheAIOhemyc7qWVlypehl7ql3ymXRjxd06PZAIGYxITsFY7CHYoKiBmD6/E6h+0MigFphGZLe+OMG8HYKxwb15M1WXitnR92VnY53qUBOYxz7iXKfbj9lhvVsL5RsS3tINqaxVXUd8fMbTrcrQx1aH0=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM6PR12MB2956.namprd12.prod.outlook.com (2603:10b6:5:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.21; Tue, 22 Sep
 2020 13:12:53 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::c0a8:314d:61b9:24ce]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::c0a8:314d:61b9:24ce%5]) with mapi id 15.20.3391.026; Tue, 22 Sep 2020
 13:12:53 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH umr] Fix register name lookup for sdma POLL_REGMEM packet
Thread-Topic: [PATCH umr] Fix register name lookup for sdma POLL_REGMEM packet
Thread-Index: AQHWkIzce78C4r4XVESO1V7IRA8Xiql0otS1
Date: Tue, 22 Sep 2020 13:12:52 +0000
Message-ID: <DM6PR12MB3547D99F4A0C252C96F7E769F73B0@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <20200922030224.22239-1-xiaojie.yuan@amd.com>
In-Reply-To: <20200922030224.22239-1-xiaojie.yuan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-22T13:12:52.388Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4070d201-f1d4-4f19-6abe-08d85ef936af
x-ms-traffictypediagnostic: DM6PR12MB2956:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB29569C0352388843787BA1CDF73B0@DM6PR12MB2956.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ywVkaDhUFbR2NetSsgy5F7EbOltUN7s9J96gyPrWGs/vxNEiUI4s5ncZ7Q/BVOzsbsKTZ1oHzYibH0249dH2eD//gSkIt2k2XrbjVCk+0L7cckJmYi5i9zyo91jqRr6yYvH0VpnpampBw1uWOJf5Omu9M7KOVAq2eaeC6+5N4Teo/H/N5u2Crdk7PiEJD3zfLxdIBbI8vqo9SePjDRbuRpEjGmd0UILAUHTau2KbyhDt88kREyjaF5C5AuUvcTTrPN5rnVSJeDic1DYnBBmIdIAchPr2ILLPCePdEllUX/aVrrY+t8DVeS7hsEqxDtkulXyFaXdMtSHFKzCC2X+xgw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(26005)(478600001)(33656002)(7696005)(8936002)(6506007)(8676002)(110136005)(53546011)(2906002)(83380400001)(186003)(66946007)(66556008)(66476007)(64756008)(66446008)(76116006)(52536014)(9686003)(91956017)(71200400001)(55016002)(5660300002)(316002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: wGNvkUbk2/vmwiNXi8AgrGGnmdKg23J6waT0y9SrYeTgV3mDPp/Opa36cgUPdyUe6KSK8tCnIaYmZOTpkgtWeNBgzcky5MlZnZY9XJW3IitCgW8H4ioci3i2fA/q6uxCjMtpnHE013Z9bvuHeLZZrnH1IKJAtgUh7I97MRm7cfRzV7ayPr1dE99lntS+72VNBDSrGYxapQUNJTaThbn+Pred1sqizR3EjFN/VVXRKYWta8cmbLd6/dM1gREyMq1jduu0YiuS2ibJDYxaN73RDb4MW3B+EPscv59SH0UJYnWpvImtv4QmNMTufaQR4BP1zML3hrHlHm2919rP0lNTwkYDG2gt0MmbN/MEvFxQ76r4iVy9J9l4uY1lPiatLnPozlxcUaRjCXKQHcWjktqZGilP3W4lLFu3jWC5uA4ahk0PFUyVKOS/xjcWde2QEY5pGNpsipT39CHacoJmWx9ZH+C6Fp5s9vPFKGxZAUY/ERlxBaoO2BwMZxObSk+ufacPJLJH7G7CPk31v98qD6GIyv5wwJTOEqZd3jkdokZwYaLm2mQNtZqeM3XTCZZVzkWyysH16iTYeYqACWRyZ+lW61C5Xlkqr9zERLgajhRzeySFHxkEBBcnbO0xDDAT5rLaIl0JdG806xPgD92HaX4wJw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4070d201-f1d4-4f19-6abe-08d85ef936af
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 13:12:52.8909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6fu0tMvhZVZNNe1mx8c7dxl4TtYp5bp13RaWZBsLQP5SlyvydggcWU6ivYuymga+naJtqP9JdV/VzPkuU4fltQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2956
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

Hi Xiaojie,

I've pushed your patch out to main.  In reviewing the SDMA opcode I actually noticed a couple of other minor things to fix up so I've pushed that out too.

Cheers,
Tom

________________________________________
From: Yuan, Xiaojie <Xiaojie.Yuan@amd.com>
Sent: Monday, September 21, 2020 23:02
To: amd-gfx@lists.freedesktop.org; StDenis, Tom
Cc: Yuan, Xiaojie
Subject: [PATCH umr] Fix register name lookup for sdma POLL_REGMEM packet

POLL_REGMEM_ADDR_LO/HI are in byte but umr_reg_name() expects register address in dword

Signed-off-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
---
 src/lib/ring_decode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/lib/ring_decode.c b/src/lib/ring_decode.c
index a74229d..b5838d1 100644
--- a/src/lib/ring_decode.c
+++ b/src/lib/ring_decode.c
@@ -1904,10 +1904,10 @@ static void parse_next_sdma_pkt(struct umr_asic *asic, struct umr_ring_decoder *
                                case 0: // WAIT_REG_MEM
                                        switch (decoder->sdma.cur_word) {
                                                case 1: printf("POLL_REGMEM_ADDR_LO: %s0x%08lx%s", YELLOW, (unsigned long)ib, RST);
-                                                       if (!(decoder->sdma.header_dw & (1UL << 31))) printf("(%s)", umr_reg_name(asic, ib));
+                                                       if (!(decoder->sdma.header_dw & (1UL << 31))) printf("(%s)", umr_reg_name(asic, ib >> 2));
                                                        break;
                                                case 2: printf("POLL_REGMEM_ADDR_HI: %s0x%08lx%s", YELLOW, (unsigned long)ib, RST);
-                                                       if (!(decoder->sdma.header_dw & (1UL << 31))) printf("(%s)", umr_reg_name(asic, ib));
+                                                       if (!(decoder->sdma.header_dw & (1UL << 31))) printf("(%s)", umr_reg_name(asic, ib >> 2));
                                                        break;
                                                case 3: printf("POLL_REGMEM_ADDR_VALUE: %s0x%08lx%s", BLUE, (unsigned long)ib, RST);
                                                        break;
--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
