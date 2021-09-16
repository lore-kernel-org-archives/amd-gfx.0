Return-Path: <SRS0=YYL8=OG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D935DC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 18:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA04460FA0
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 18:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AA04460FA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A3346E5C0;
	Thu, 16 Sep 2021 18:48:24 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-oln040092065093.outbound.protection.outlook.com [40.92.65.93])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E02ED89A9A
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Sep 2021 17:37:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LangI8Rxf60vZZMzoL8X6CvZt5yQE1mrAJ6WIN3wlgVg3pL9mmLx1FfEDoTxMTP429Blz2tOBxobDah10yUj/xCDAWTDpQ9R5xX/YNVvO4PITq80H2LxZZ4wpR2F2iFkb1YSbbaFPOmP3M4Ed8kNlaWwja4+i53MWkpVRvOxz03lpwfGLDFdfFpKxN/WcF8QxMtikZXDtPm7SQgj4QOnOeCQXddYm0Oo1SboqfFxTk3Tbc1jMMqkqGRHa5KGwi/jwypMXSeg/h9GK0JrL63dCzOgByXsKqnYJfPd2FZPh75HkT4sm+XpSoIuguEbo8LRjnxVYgPKrg/R2IzD/P+OqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=bwtESidDJm1sZmzJ/Cv2uVUFs6OTeSC2CpQ/TdUBxjk=;
 b=lLC6HSIcXAmFhiDy+IbzCV3nXjo2mXdHjrBF+8dm59gq6ilKydRXwQ0k5/2ZrGERILLuJj0s7tz1I3N88gH6SkeWFig8T3yjgbOnEx8KbalH+KqtzNcksV5Mfyy0nbzGhY3Mw8CbBgW71eM3um+eSPMzy40zrLvvp/AOJSMRhW3SMXYkJGZqaPt+hDoX8vbya7GvT+8lFofObD0jYXlmbx6l1oemnvIlD1JXi/aTINfWyL57gZo8gcFzQeZTYyVN/snemY9pPUdDYIbiMuzUEP74DN8aa53zZs2tjHemS/UmiAkHTGUziEo8JXBVVcp2HoqUeSzh2oltBnEab4la6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwtESidDJm1sZmzJ/Cv2uVUFs6OTeSC2CpQ/TdUBxjk=;
 b=NrxKW6gF5fYZlB4WOTHAAXENpguwGQfdjsbN+Dwrq6olZ6P7zFQ++f/vpsbOXoF+ILYlY5C9dZQhvH5bLzXujEYoXize0lrM8i/1RFQdrPY/sOlAjN5GHpTaZ5YIf+gWXxIxMEb6vw8BTjxLtJu7Q2bg2/p4zCBhKe99BuLAvx+E62JAfdRA7urnB2ysTSlmslMecnFWdZU9ntJkvhumbr0lOFS1yxfTCZleMJcZRMireumiH7BVv1Mlu58erHtRyYHdDz+V1NLdfP9E7XFnVzRp3GL0Yiu7Bn0BltCzXbLtbPw5JuI6FgSRXI6U1KSB+l0H6hB0RHsVJ8gNtjMU9g==
Received: from DB5EUR01FT064.eop-EUR01.prod.protection.outlook.com
 (2a01:111:e400:7e1a::51) by
 DB5EUR01HT195.eop-EUR01.prod.protection.outlook.com (2a01:111:e400:7e1a::409)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 16 Sep
 2021 17:37:54 +0000
Received: from AM9P191MB1857.EURP191.PROD.OUTLOOK.COM (2a01:111:e400:7e1a::52)
 by DB5EUR01FT064.mail.protection.outlook.com
 (2a01:111:e400:7e1a::339) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Thu, 16 Sep 2021 17:37:54 +0000
Received: from AM9P191MB1857.EURP191.PROD.OUTLOOK.COM
 ([fe80::7852:eb69:1c7c:a8a2]) by AM9P191MB1857.EURP191.PROD.OUTLOOK.COM
 ([fe80::7852:eb69:1c7c:a8a2%8]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 17:37:54 +0000
From: Davut Demir <davutdemir16@hotmail.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: I get this error while trying to run 3D applications or games.
Thread-Topic: I get this error while trying to run 3D applications or games.
Thread-Index: AQHXqyFyEnJL890cbEKq8mnyzcFNOw==
Date: Thu, 16 Sep 2021 17:37:54 +0000
Message-ID: <AM9P191MB1857E1C7B1552C45D3BA9D55CDDC9@AM9P191MB1857.EURP191.PROD.OUTLOOK.COM>
Accept-Language: tr-TR, en-US
Content-Language: tr-TR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:DE41131E4ACD0039C1E1535616767626BB53DEA56139D525A00DA82A7E264DD1;
 UpperCasedChecksum:E7ED7EE9E4A564B3CD6C3D6988B1DE65B3DAA540A7DD43CEAC7A0AE60510013F;
 SizeAsReceived:6677; Count:41
x-tmn: [Jm86u6/09Nbu5iAgNv9lXofuUzzKsrpO]
x-ms-publictraffictype: Email
x-incomingheadercount: 41
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 4eb02d1c-7d27-4764-a7ee-08d97938b6da
x-ms-traffictypediagnostic: DB5EUR01HT195:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uo7Z7jfoyE5FuTL9AaCLbSMe/5y6sbC/46TQeBWxtozKgv+SxR22kZJuMns4eRYeRixdx5dEAFVqWqNzaDIB+mdXjpsN+sE7EMND6ixm9CLdQw5++rRSuhbD03xGcAX+b+1taomNDsgGZgM221YgvEfNB2JdVGv4ZhmJYy9Gl6xJOE2mlhkhzm2t7lFynCNgk8gcQRZWlI/gUJY7A5lAmjdi5YOp2XctJjwZ/95chFTJ8/gO5l+JzuEhLUJGt44uwaPQ8+2gFabPa34lB4TdG6StH8j1fYD6M1M8AIRQonvEtfQ0mKtaWk0CKJaIzhLZFJAFcVigI/fQ4oCkWf1gZe+oZ2AqFTdX5e//BXipwhFYKNBJt+eMslB3h0MZ+pqxxK9zAFW9VP97yJjN1ZGKGiEuEdtu9Wl+b/jOXReq9bZQ9njyV22iXqnBUUuTPHMX
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: eLk8MSb//LKp2rD8e/fFyyZXZR+Oucm1eyVWGniomekOnNxJp+Dnt2OCAnK7sWqoje/LCjfpJzRl06PzR8PHMFN4MvnonEIZCMF+q/Cr9Z49HSocziPeRBqf9xk1kZzwkLJuZA1kC+pZWMn5ZjPd/Q==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_AM9P191MB1857E1C7B1552C45D3BA9D55CDDC9AM9P191MB1857EURP_"
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT064.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb02d1c-7d27-4764-a7ee-08d97938b6da
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 17:37:54.1921 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR01HT195
X-Mailman-Approved-At: Thu, 16 Sep 2021 18:48:22 +0000
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

--_000_AM9P191MB1857E1C7B1552C45D3BA9D55CDDC9AM9P191MB1857EURP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Eyl 16 18:49:02 davut-laptop kernel: amdgpu 0000:01:00.0: PCIE GART of 256M=
 enabled (table at 0x000000F400000000).
Eyl 16 18:49:26 davut-laptop kernel: [drm:amdgpu_job_timedout [amdgpu]] *ER=
ROR* ring gfx timeout, signaled seq=3D527, emitted seq=3D528

--_000_AM9P191MB1857E1C7B1552C45D3BA9D55CDDC9AM9P191MB1857EURP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div>Eyl 16 18:49:02 davut-laptop kernel: amdgpu 0000:01:00.0: PCIE GART of=
 256M enabled (table at 0x000000F400000000).</div>
<div dir=3D"auto">Eyl 16 18:49:26 davut-laptop kernel: [drm:amdgpu_job_time=
dout [amdgpu]] *ERROR* ring gfx timeout, signaled seq=3D527, emitted seq=3D=
528<br>
</div>
</body>
</html>

--_000_AM9P191MB1857E1C7B1552C45D3BA9D55CDDC9AM9P191MB1857EURP_--
