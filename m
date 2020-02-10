Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9CFC352A3
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 14:41:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20BC92082F
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 14:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="YwMu+RC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BC92082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B43BB6EC59;
	Mon, 10 Feb 2020 14:41:02 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05olkn2088.outbound.protection.outlook.com [40.92.90.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B68B06E20D;
 Mon, 10 Feb 2020 13:20:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihRbn44kyhV5OCW3gIGiGCKRm8oKnzE7Dw6Vkm0E1BmSmnzblBdIvVD+klIMYGtULv3SFk+Hdp7I/aIInMOaBa0x+Wa4WdF0ZzFZWFjofCfihmSIrAjuNa1W9N2yB0zGXjgWngs3imzQTtSRchv+kVGUc4TjD/poPd/t5yRxS3yEYLuQP41hFR5Y/GFCyC5Zglu/pEds+bWNUUG4y1yFG9rNPYYx8FQZw7qNg6UPoC3QaGk7CPW1gMgJL7M3dc+3Mls9AJNQjq7/Psf1uwxw3fDkHTm6z6NLVQPeaCj4GhOyED/fZeUUUjhEI1BOTDU2UrzwZ+F1mpJ1RFoEMhyR5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN+va05ZbjMyKEWzwdO6T+qVBco4SNlpNcsR+DK1xqE=;
 b=cqYWdC43FDTr//2DUnWrJAZVoxtQmAL1/wLoIQjiy05cy9t6Uth5yMmG+xoMKvK4hB2Fe807mrjo9rBSATtdKYYTgvmG2y5Pn+dWxQlCl6nqYofQXJtpsnpgf07N9kV9O/0ewoAjchCSfpT/TBco5d2mIKOqYDcv5wMUy3WaBpm6X3LVu9t749tCRVc32G2fcXLfaAag9h9M1F5/DX8tQEJlenxK9ShDcsdLXiWiEmGr5sFgFx1ZnbRJxebxjrX1RFyeJX/Vs4haFErF7oTXdZx51F3YjL2uStNNAikAvOlw/P/JzMASWvHAJWIpxX2FV+ylBSgIrZBSi28Cyi8QhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN+va05ZbjMyKEWzwdO6T+qVBco4SNlpNcsR+DK1xqE=;
 b=YwMu+RC2KzZNFpTTlKe5ZcqCNtwmuWRo3u/peCcE2OJRZ0H0aYlAwfm2ruesZF8a7bcz7s45h18lItKBNR1U07FxKVS4+CT55eyqw+w/RpzaIdm+XoGpxmHKGnGeTA2mzc3mgpGDAHpWECCjP5zgo6jyRnlVCvdOb2p6Dp9KoxOroBgVQ8kwneP8vhUKJOlkn1MAkTzFGkMJJU8rhgHUe70QqfIiBR4IiOZuify1cSyZ7XfAl0z545iqHbyAKwzoYr5EVGwr9fsZmCf2mIXgCURmepaW744ru+R3h2OB+9lILbrEx34T0A2cmJZg7KPC4fTCzc5ER8qKdIaVwrJd4g==
Received: from AM6EUR05FT005.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc11::36) by
 AM6EUR05HT073.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc11::322)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21; Mon, 10 Feb
 2020 13:20:50 +0000
Received: from DB7PR08MB3801.eurprd08.prod.outlook.com (10.233.240.58) by
 AM6EUR05FT005.mail.protection.outlook.com (10.233.241.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Mon, 10 Feb 2020 13:20:50 +0000
Received: from DB7PR08MB3801.eurprd08.prod.outlook.com
 ([fe80::7435:b1b7:7a14:4095]) by DB7PR08MB3801.eurprd08.prod.outlook.com
 ([fe80::7435:b1b7:7a14:4095%4]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 13:20:50 +0000
From: David Binderman <dcb314@hotmail.com>
To: "harry.wentland@amd.com" <harry.wentland@amd.com>, "sunpeng.li@amd.com"
 <sunpeng.li@amd.com>, "alexander.deucher@amd.com"
 <alexander.deucher@amd.com>, "christian.koenig@amd.com"
 <christian.koenig@amd.com>, "David1.Zhou@amd.com" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c:33:33:
 error: Buffer is accessed out of bounds
Thread-Topic: drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c:33:33: error:
 Buffer is accessed out of bounds
Thread-Index: AQHV4BTGV26MS1cglUGXtSYHs0rE4g==
Date: Mon, 10 Feb 2020 13:20:50 +0000
Message-ID: <DB7PR08MB3801743541D8F3F1D965D0159C190@DB7PR08MB3801.eurprd08.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:6AC9E1CD492ED63E036590B5A477FDC6751B25C211708346B018CB1F36AD4A5B;
 UpperCasedChecksum:C5078E19AF43812ED6008D0E9F1188E540FD5A1ED9BD9BF906908716EDE261A3;
 SizeAsReceived:7498; Count:43
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [l5IqIsAvcQf46Y+aNpWwcwnZp+cSkKKCaK2ddA4Rh/ZjWNQx7RJYB/TuvprBnxfk]
x-ms-publictraffictype: Email
x-incomingheadercount: 43
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 56799580-a37f-469f-d7e8-08d7ae2c0c45
x-ms-traffictypediagnostic: AM6EUR05HT073:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lp3Ub606pyqbi2+Rh6XxQxXQ26Jx8AAEwsF1foGk3LuBNUYH2SBl6PuwJAKNUTBcMhOjtcjcy4zlfSeiMwp1PejSaRYFfxa9WFELnaoPuyix5G9PxefIoXI2umRM0p4lVzmUgkd5ax/+aqyIPXHL6CbA/VhKs65NN+TZzlJGk6elNJvUCWuRQMI5QYMtEnsA
x-ms-exchange-antispam-messagedata: gPumPVKlPMvoMVz4tHmrKQC97EcSLt/F2wDby9Fy787lisyHPCVo86g4USjPRRSQ8Q7l/lOUn7wnL6Wy2xn+4TY7sdBInoicGGwKCWOen3o7UVeTlSCIr1n8jR3wdCjqmbx2bWreowWLJfrD9pHQ5kLgDbs2NKSrat/dbn3y0Ib3ZIp+ei9r0A42MpCcsYgtILOAzmRb3Z2Lhmqv2cOMMw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 56799580-a37f-469f-d7e8-08d7ae2c0c45
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2020 13:20:50.2853 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6EUR05HT073
X-Mailman-Approved-At: Mon, 10 Feb 2020 14:41:01 +0000
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

Hello there,

linux-5.6-rc1/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c:33:33: error: Buffer is accessed out of bounds: hdcp->auth.msg.hdcp1.bksv [bufferAccessOutOfBounds]

Source code is

   memcpy(&n, hdcp->auth.msg.hdcp1.bksv, sizeof(uint64_t));

Field bksv is only five bytes long. Suggest code rework.

Regards

David Binderman
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
