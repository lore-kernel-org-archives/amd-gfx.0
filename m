Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478A3C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 17:36:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003C622518
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 17:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a7lzKx+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003C622518
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 230066E171;
	Tue, 14 Jul 2020 17:36:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D37846E171
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 17:36:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmBYqjTvR4meoCo+hWuybcgaLtr1fR/L4vDqMU+CfU12CnszdcNG1K4ktEf6KoTBkUDrwK0rra7ZQVJnR1K4pyE6i21aFvkN7pDw7XOgUPQ7c6D8/TjViqehAerRwDeQs0UqS0KY/3LhLx5wPeoZJhgjkZi9hK5Uw2h+MBroYZOHA0cI472TsozTahppq+AzGtR8y50ogMgLkfZ7xigULgXaDbi+bGx90VnHjy7mNN4OsCE0mMFxP1XjznLC685rmqdqFslwpGuVdKokq5ifhpeJDPHcT8484nfB/mxvFMhA7CD8W4nSw/bRrKgklWWTprlpkAbeNNv8YpfZWa62eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IH6xvWV5jJkOgy7U6We3d4xjrAveo3OUtipAdUpFUM=;
 b=gWXIreYAVcOXvV4ZpN5u2rj9dRK8nXKfV8Fr+zbp82sTUN3PlSgiTPrVvfzNh2msRsz+RSVnSUsn30TjiZKKHqvdhdulyY69u/U73YBc4Orx7bLSuTghCcVKCr8Tk7b1cwdJu+Gtul7JGzlAtJxAOcvhch+IY1U9vi/raUgz58H7p2iD/PL2zJyK8rEvlCM5DxFiR01q7vuC/bxMQ14Z3xDJTONJETPScOM21fZHGB12CqXtyHRTMgkGg/EkMkHoGI01sA3VEIjgxqu3KqCQMi8aaDcDDKeSYcVuv15O9tQ97APLrEu1585RxZY0odcpnHrM54SHKh8blQwBwx8GXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IH6xvWV5jJkOgy7U6We3d4xjrAveo3OUtipAdUpFUM=;
 b=a7lzKx+3F7Y9ei4cjgBQCn3s0tlgByNiM6iuJoyEtscWiMXBEgPs3vJ2i2ju1P0rIagO1UilAfwPsB8eQjxcAkiJIiA9XWrl7o97Ga0P/K8oAoGzNoXOME2dvs6sp3MYYkmj9tvfopb5qVlGm20ViV/MDu9Qr7FS6ay4AUJMtfs=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM6PR12MB3980.namprd12.prod.outlook.com (2603:10b6:5:1cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 17:36:01 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::446f:752b:f450:e89a]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::446f:752b:f450:e89a%5]) with mapi id 15.20.3195.017; Tue, 14 Jul 2020
 17:36:01 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH UMR] Fix off-by-one error for decoding sdma linear write
 packet
Thread-Topic: [PATCH UMR] Fix off-by-one error for decoding sdma linear write
 packet
Thread-Index: AQHWWZXcB5dNk1f3HECt2caZaVyc0akHHfGvgAAXxQCAACGQZg==
Date: Tue, 14 Jul 2020 17:36:01 +0000
Message-ID: <DM6PR12MB354778F6611AFA0547CDF295F7610@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <20200714041830.29358-1-xiaojie.yuan@amd.com>,
 <DM6PR12MB35473F5ADE458B405E1F04FAF7610@DM6PR12MB3547.namprd12.prod.outlook.com>,
 <MW2PR12MB2586140707DD884C1FE54E5B89610@MW2PR12MB2586.namprd12.prod.outlook.com>
In-Reply-To: <MW2PR12MB2586140707DD884C1FE54E5B89610@MW2PR12MB2586.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-14T17:36:00.692Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2931544d-d818-42a3-c5b1-08d8281c6079
x-ms-traffictypediagnostic: DM6PR12MB3980:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB39800746F7A7ECE75080B109F7610@DM6PR12MB3980.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:568;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ORr8kQwu6PWgL6n3c4lA9zMPbvP92Z2P5IG366ggpN6lwAY+jUb2My+jlG4EeybfopaO9KPrM/TEfsQOafpYbG2TXUt1kbqXM6GwHM53MKcBpnx3aiNpDg8aTSHNd+Ji9m0xPfJqVhQz2ICWGzxFP8tJ8GwZF1jnaipdzJlDWalc5yG2jFSbqhMbGrw4lV98XKibVWOnG5TQkD2Jd7TnBUs96sShyPllocHXD6xGUDc/269+WEyOo+KGhPMBsgupacllozfFTNX8PbFcC8trkjpp1N/CSCzduKuTHKevgLbH5s0t23a1B9sZpZaWx0IktzC3EwWdUD/oAGEBWq/L2Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(110136005)(9686003)(83380400001)(55016002)(53546011)(6506007)(2906002)(71200400001)(316002)(8676002)(33656002)(8936002)(186003)(26005)(478600001)(7696005)(66476007)(64756008)(91956017)(66946007)(52536014)(86362001)(66446008)(5660300002)(66556008)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Za22XZCJfPHR8OQrHZz9DNMk1SjTmQf6PL9ZOKbTo3+q7DVxx1TfxbDQyEzlKnd3Mml+PMNTbDAtDIrjTVJQryppPqpqP8y+Qd5LBYUSToYw9ZfeFeo/z3ZXVMerjVVaI/g+jgWWhCSDO2B+woOBKAVo/BhFC32dyEV8okUUQDEUYlkJfVi00kgE5+CHFPqfKmf6e4IOUD72UZ+awOTSm8JPMhZnySuLTD+HVoHHL016PhvfUkP2ePt0q/1EBOoZdK8qFLjP08DcV/9s1AQOpP3nFWF21c86jQwsthkcTBlIfglnvmjYv4lN1jnESMaGthQU4d0fIICO8TE2LMUFKJNBj8mhmLAuZuzrnCnTzll7hLllEn+XaP82ekOJKrAzsHIBEfAJL0SG60cxHB/5ST0DjcFhVIFpfMQ62yoDuSM/TtMimD27T+rIw8zXYi7wfIam8+u0IZ9tf3YHHiTcMxKbG0eNv07l8BZ5UCtkvjo=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2931544d-d818-42a3-c5b1-08d8281c6079
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 17:36:01.4564 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MugQff4XK2c5j4L+Ue0JGG7SqfVD7Zdxr3lzs9/NN0FxzZCFcQEnRmxwJLOlkZ+4QigiixLhRTrTpltoqCVAiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3980
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

Applied and pushed out to master.

Thanks!

Tom

________________________________________
From: Yuan, Xiaojie <Xiaojie.Yuan@amd.com>
Sent: Tuesday, July 14, 2020 11:35
To: StDenis, Tom; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH UMR] Fix off-by-one error for decoding sdma linear write packet

[AMD Official Use Only - Internal Distribution Only]

Sure Tom, here it is.

BR,
Xiaojie

________________________________________
From: StDenis, Tom <Tom.StDenis@amd.com>
Sent: Tuesday, July 14, 2020 10:11 PM
To: Yuan, Xiaojie; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH UMR] Fix off-by-one error for decoding sdma linear write packet

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
