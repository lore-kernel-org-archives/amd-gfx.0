Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36769C55ABD
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 08:50:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8310122240
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 08:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ngPNuvSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8310122240
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3C9789DA9;
	Mon, 16 Nov 2020 08:50:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03EE789DA9
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 08:50:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORi8Y5B53gC+YykHJWG2bdPiiLNUhfebjznC6I79CXlZd4eLppiIlDBP5zkKgJkS6ucMUzWIz5pqGRbrSWKhd1LvaqGYXUAF3BTZDWIG/n5spAbelODY20cWLji8yHLZHejVEzklSv9BimCkwQyS5IIQ5agZJ4p7WINjPXy5eFwXR/VvsoZBpTA6C7cC6UXw/vRzZXKGpvZrb3Fca3xLswjfDrguTVL1Eepp49XXrEqFBSx6987gxsdXAFomrpm3KnzvpHI7LiqwUR33gYw4Wtbq2yJLlLowBt6A748PU3Jh9ICHD0rka++kjBOhziE9e5Apf5XnYXUyNa2BVbhi3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WC++cuLOtzl7y7q5qirvCaUB4EaIE2FPcz7+xOQFXQ=;
 b=CkNG+HSV5CmWWAwKQXbolhDKwjVEu4GMGAdo7uZffHPRaikeIB/I3Gp3FV5MPI83XCiR27PwV534weDp/OTFJaBzBNyLitGlgSSBfadtep3OzJIkH0Vd5Cy49HNiKYicso4kiJCCxMs4vdcwZzec3X1cupW6FEVH3r+JXH/QG2pgumBCGw4VbbICstk2zwlvTHqE1PyZ0O8Loc7sYWIuSx/CwuODLahWKbpLp2JhQ2CYWNdIJrOfFGmrQj+1NfmI42EbKB9RCjNMjtWfu4r+xWt3C3YXXFUMOfVPAbmWPe6MeGjbvitIP/7PTNqqrqOFmU2cKskIn/XQiJCaKxkE/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WC++cuLOtzl7y7q5qirvCaUB4EaIE2FPcz7+xOQFXQ=;
 b=ngPNuvSUI6/zTfEwMNbfL8QcHw80lXfW9vb2L8BhnnycTsj2DfcWOkwI1LtTUrQLGmVxgNKdpBMTIQdFPF+BdASpRaUevJPxm9sQ9rS1LzxUvm8DsQGvDKm3HDi7QQGj1X4bHJcKJQ/GYU4/vIDKnMwdRie8I1fVm/eezToFRdQ=
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR1201MB0237.namprd12.prod.outlook.com (2603:10b6:301:56::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 16 Nov
 2020 08:50:47 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030%12]) with mapi id 15.20.3564.028; Mon, 16 Nov
 2020 08:50:47 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Recall: [PATCH] drm/amd/pm: change the baco parameter
Thread-Topic: [PATCH] drm/amd/pm: change the baco parameter
Thread-Index: AQHWu/WTTI8D4GbPIEWzPvAeKIeQ2w==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Mon, 16 Nov 2020 08:50:46 +0000
Message-ID: <MWHPR12MB1854D486AF9CF7304C4A7C13EFE30@MWHPR12MB1854.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e39cf4d2-7400-4199-df67-08d88a0cb607
x-ms-traffictypediagnostic: MWHPR1201MB0237:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB023780599B5AF5D4B2E2AA9EEFE30@MWHPR1201MB0237.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mq3ceDvAz5W/k8dORo3xFSiPrs6jDkZuhflWRGmUlrDC7BFTGcKoNKEV4QEK36U5BtoR1Osy2deFg6ZQ/2G/fz46/CQavsrDunofmEc//CV/Mjxeq9spvUDSMYHNmMCZpNzR45t7kDsFActe9IJ4x2blVszLSHVxwEFmppn5oYAPyGbo32ap9WLizBSQmc7R/bmOnZPsRcO3pWjJDI25PhQCpRl4mplLVblC8LbL2eAcwL9LB3NPU6JVyngXPdXICkOgmUz0hIhCJfkTM6Ze3k3/mILnuArO/GbIMz1sX9YgSa2LNzdmw64/XD32e4F3kwsiA9lAEgW5hX6JZvzwNg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(86362001)(71200400001)(55016002)(8676002)(5660300002)(9686003)(83380400001)(4326008)(110136005)(186003)(316002)(478600001)(558084003)(33656002)(26005)(76116006)(7696005)(66446008)(52536014)(64756008)(66946007)(2906002)(66476007)(6506007)(66556008)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: zohgj9QpyOZA0bEaVypH2UlaFWRlepdCRw0hgnF20pnOrpW+UbSPVGVuNJmlB1fQWsHXZWXNr/K/G3iaUACSCMH8HIJPYqI91j4SgN0VT/xBXMk5feqZU02aWY99U2oDp8FS0BiEEBy1IzSVQWwu7+N0S/T0pDKBr+Qmor37t/2vpq/if4wptAJrU7wuy8I/aOdrky+v8BxXcmTAMP+Z+AUS3QlXiBnWCnZuUNOQV/Z9TxDyVg2dPzdYnkMoqYnI7iAEnMr+TfaOFLXV1HLiGDTMIgF5RmAZDczoQ2Sy7bxocG+Jtd40j4ENWLbcPcHIpLFChwLf9mVDtr7N8+Gu8OUrJqepsNtwAmaSQ49evAbE5E+OUSE4y2oeOwM1Z01ALXeqeP5yCIWZXRhsLc26AF3YFBOp9b0yHuZKroyMIG40zdn5ZiGJB7Ck98weT/Xkdek30+Ipt3YZSiFxD6M5oXadgPkE8etnxWggEhx9QIrUQ08YzUDhgBHnSciA/zCRDAUHBg4Oi6MXDBH++owyhQyfWsXv1/mamZAxktFnmae7o71LjiVHK7DQTkpjOGqZ0v0kVa/Y5twrdiy5TWfnlBEMoQFnOKPYeUe6D/I7V4PP+fcaZJ25qWP5Scn4IujOdREL+UmOcps15SUQoCSvnH0hkz9kSMlaaabzIZQ+j4mwt907o6Q7nP/P1CnhhSCk01KqwcMGgyfe3pgDAOye8fCJV8CzZl3MbTegn7EowpN4mY6S1bF8qNc80le7NSvrlPxdKboI3g8ZVkM1Sr/drUpoBNV4NPDMmkgNEoyslUdxfZ5S4efGM9CQ6z9SmRN2BSv0PQeIg1gjmiFnPqWvXhSLIfR8YgwYGbg04OiUopwuuCJ+4Xkt0BadTaqGUt9NojpKk1llRJmowpEQSDQV8w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e39cf4d2-7400-4199-df67-08d88a0cb607
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 08:50:46.9495 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UUofA9jiwgFY9BmpEjBUYgxmNG+VhKPctPxFov4HxOR60/skIlQPue39CjhcbAPN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0237
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Gao, Likun would like to recall the message, "[PATCH] drm/amd/pm: change the baco parameter".
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
