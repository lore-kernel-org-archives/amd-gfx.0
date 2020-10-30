Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C50C4363A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 12:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9558220725
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 12:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="r6VVxXiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9558220725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5D3B6E9A8;
	Fri, 30 Oct 2020 12:51:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8F966E9A8
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 12:50:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMyXGYNEg9Zr7oQQBkQ8r9+dKUU2gX3aMUEu1HnZ/EpbBZApdN/NMAMBnGcsX8ckk6/t61ofoegZpV8H3IqiEkXmuopXGdJfdbTwiRHwaqw9OhdWYsvjAnpXwL6krFDEB1wZZzdomfRF6qyRukm64S7P5jjGt8Bi1QWf0GvXBP9KyxLrCvph0qC3EFD1++5EE7llOmCo8l0T0g+aARg4iy+UdBeEENt6nnlb6u/6isHXwmj/e3JFroEKi83tNJoxrvROrvq3JaWMxJJ5s2AJ+fjK/byPIETV4icT6IJYVbTlsHZVetPgfmGDDNgNaYo5XIK+emabPAntpMFCQqXd2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5WfOTj7quiVqptOtoK/REbTa6Jgc/jNG2YmNbJhkxg=;
 b=S5B0r0T2jMmmBWeRaw6xmpHpqbzt6MhZ3E6e0djd1JsOJXCP695AyOKBaLkhWYQ6Ji/pbi24d65Ih74Vn9JjXrVJYvj2FMnMN5oYADrAmiIK5HzrS/kcMGl2RPUdjvLlYjiGrBijnzrbrwgPuVLFmdeaCbKwpN7xViRuxnbmQWNiDq+hjDPNiyXP2SlcVIUDQ36ID4MDV4ROAH8qEFifq9W/mafTmbU/nOfY+PajOsNEyOLJJ9iu8h5xrqbz5g51kqTc1kExHU0iK9DB5Fu7tH2dB8ge6Q5ed7TOyDkSgE3qFJ5r9KW24Djh7OU/p5vDhZWPgkUJbepRXqY8RaH7RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5WfOTj7quiVqptOtoK/REbTa6Jgc/jNG2YmNbJhkxg=;
 b=r6VVxXiF6BYsjfBAZ3UW8RgAD4pr5y4TXY6noTUTo5s5UJFhR8YIHiW/vtiHh4DIksA7qP6EEPUsDjdOmA6c9VcRNAOeVkopJ7UhuMYMztIWDo3o2ZC3/GU4GlCgZDhofOAk04Cr9SJdwd2PxmFAJoiq2SqVF+Rn4nlsiRVQyN4=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR1201MB2505.namprd12.prod.outlook.com (2603:10b6:3:ea::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.24; Fri, 30 Oct 2020 12:50:57 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3499.028; Fri, 30 Oct 2020
 12:50:57 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Recall: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless
 SKU
Thread-Topic: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless SKU
Thread-Index: AQHWrrtPyQ2w0M+smEiomcXTCY0lVw==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Fri, 30 Oct 2020 12:50:57 +0000
Message-ID: <DM6PR12MB4075729776A9271FAE508D03FC150@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 31ca2c2b-7814-47c1-c7a3-08d87cd2727e
x-ms-traffictypediagnostic: DM5PR1201MB2505:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB250573706EB33EAECB041342FC150@DM5PR1201MB2505.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9IBaRXgvptgISv3j5GnwtadItRYFv88D0XbVWT89sWbZvuDB3GZGxn3pQcDTd6P7VXrFt00mw0/EL3zHQoH411W190nfVnFiRj3USKFwe8Emtt6KtAXw6JVQlzlMf4CPwNoSzE6Fcz9b1QPmY3Kosyf6L2psJWFouMkYWHDwiXXRzB+njge2WLbwE5XS096HWTTYBLMa7C9B6rj4gtMyIeZAWVqsHrrzvm/iCKhBcwBU7x1+Br1Veb0+nz+1s4lJmx67qxLrDvuk+Tn8XU+FcdnIvJkM1O2lxKxlviXrvUnaHEsM1SQFhQhWWVWObxq1yZA7FFy2HLXHs00+XPy5pw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(64756008)(558084003)(2906002)(66446008)(66946007)(52536014)(7696005)(316002)(8936002)(5660300002)(55016002)(9686003)(8676002)(86362001)(4326008)(478600001)(186003)(66476007)(6506007)(33656002)(71200400001)(54906003)(83380400001)(26005)(76116006)(66556008)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: JcaQVtRtc1yhGqrnCVLxSHbE6f45p9eScNBRhwInEZ7hBNToYl/LTcf5SjHNRBhLGRz1MJFetYjbBuc4gqlpAX0iAWsT41+N8l0BqrbIhQhcapKBpf6/070PIweP+HFMadwJKPCUZ5mOhOy8co7Jo73t6hDI1HtZYCIHY2SnqSE3e16sBNTbPOnpLEi1eltQMnZcn3Y306C7gw8wcEEpEgGuB/dXFGqwuJGmxPm8NlTwy2hbxLf5J3O3eXFmvNmb9mtRtyYnyKOyqULq8ceHcPibRwB9dRsrLRuDc3jwTlFJIjyh+7tw8yJfqkDIrw4xjMVrFnZ/W7xUKWlKvZITHM8NGqpYCGG1ScQdSjLploCW5KH5kHuJUS8Dg8VOhQ1g64pvgKioOS+EPwYqSb4bxjAghjrpeX0aWv8Db+FyEhTXCw6jskWSdCWGGWm8F8ATxUQAe4Sm997MYgyuKssACC/6DYRL+VEpon/i0u+6mZ1lNvAcqiL/Vm5dcelI4gNeHljBxTMSo44yO/+uIVeIAywms2Z7nsj75JSXOngVfj+YAmHXPcZE4kpVKJlP9+YRqXSFbYoi6biXmFSBv7VyKjyWPFeMxToC1C4+fR+Hpirb/+/d2T23LZEo8yzKluh6XUwtaJB2N/DAnWlAPE0QeA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ca2c2b-7814-47c1-c7a3-08d87cd2727e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 12:50:57.6886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PbieNOowSfEYx8oRkHWMoTlmE5XdFLfXGkcdpO3JCjfCv+Ai529rUnh4Vv2EgKXohzN25/qALKkNFqSjWfUs0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2505
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Cui, Flora" <Flora.Cui@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Zhang, Hawking would like to recall the message, "[PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless SKU".
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
